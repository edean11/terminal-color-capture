require 'Date'


class ColorScheme

    attr_accessor :record,:id,:name,:text_color,:text_format,
    :background_color,:active_criteria,:overwrite_prompt,:active,:created_at

    def initialize(record,has_id)
        if has_id
            self.id = record[0]
            self.active = record[7]
            self.created_at = record[8]
        end
        self.name = record[1]
        self.text_color = record[2]
        self.text_format = record[3]
        self.background_color = record[4]
        self.active_criteria = record[5]
        self.overwrite_prompt = record[6]
    end

    ################
    ## Validation ##
    ################

    def self.validate_name
        String
    end

    def self.validate_format
        accepted_formats = ['none','bold','underline']
    end

    def self.validate_color
        accepted_colors = ['x','black','red','green','yellow','blue','magenta','cyan','white']
        (0..255).each do |num|
            accepted_colors << num.to_s
        end
        accepted_colors
    end

    def self.validate_active_criteria
        Time
    end

    def self.validate_overwrite_prompt
        accepted_responses = ['y','yes','n','no']
    end

    def self.validate_existing_color_scheme_choice
        all_schemes = ColorScheme.all()
        accepted_responses = []
        all_schemes.each do |color_scheme|
            accepted_responses << color_scheme.name
        end
        accepted_responses
    end

    def self.validate_color_scheme_property_choice
        accepted_responses = ['name','NAME','text color','COLOR','color','text format','FORMAT',
            'format','background color','BG_COLOR','bg_color','active criteria','ACTIVE_CRITERIA',
            'ACTIVE CRITERIA','overwrite prompt','PROMPT', 'prompt']
    end

    ####################
    ## Get Properties ##
    ####################

    def self.all
        Database.execute("SELECT * FROM color_schemes").map do |row|
            color_scheme = ColorScheme.new(row,true)
            color_scheme
        end
    end

    def self.compare_active_criteria(now,active)
        now_num = now.to_time
        now_year = now.year
        now_month = now.month
        now_day = now.day
        active_start_num = Time.new(now_year,now_month,now_day,active.match(/\d\d:\d\d/)[0])
        active_end_num = Time.new(now_year,now_month,now_day,active.match(/\d\d:\d\d/,5)[0])
        return now_num.between?(active_start_num,active_end_num)
    end

    def self.determine_active
        now = Time.now()
        now_num = now.to_time
        now_year = now.year
        now_month = now.month
        now_day = now.day
        active = [nil]
        min_start_gap = [nil]
        all.each do |scheme|
            #update all schemes to not active
            update(scheme.id,'active','no')
            #find scheme most recently covered by active criteria
            if compare_active_criteria(now,scheme.active_criteria)
                active_start_num = Time.new(now_year,now_month,now_day,scheme.active_criteria.match(/\d\d:\d\d/)[0])
                start_gap = now-active_start_num
                if min_start_gap[0] == nil || start_gap < min_start_gap[0]
                    min_start_gap[0] = start_gap
                    active[0] = scheme
                end
            else
            end
        end
        #update found scheme to active in db
        if !active[0].nil?
            update(active[0].id,'active','yes')
        end
        active[0]
    end

    def self.get_id(name)
        Database.execute("SELECT id FROM color_schemes WHERE name = '"+name+"'")[0][0]
    end

    def self.get_props(name)
        id = get_id(name).to_s
        Database.execute("SELECT * FROM color_schemes WHERE id = '"+id+"'").map do |row|
            color_scheme = ColorScheme.new(row,true)
            color_scheme
        end
    end

    def self.count
        Database.execute("SELECT count(id) from color_schemes")[0][0]
    end

    ###############
    ## Change DB ##
    ###############

    def self.create(name,text_color,text_format,background_color,
                    active_criteria,overwrite_prompt)
        Database.execute("INSERT into color_schemes "+
            "(name,text_color,text_format,background_color,active_criteria,"+
            "overwrite_prompt) VALUES (?,?,?,?,?,?)",[name,text_color,text_format,
            background_color,active_criteria,overwrite_prompt])
    end

    def self.delete(id)
        Database.execute("DELETE FROM color_schemes WHERE id = '"+id.to_s+"'")
    end

    def self.update_all(color_scheme)
        Database.execute("UPDATE color_schemes SET name='"+color_scheme.name+
            "',text_color='"+color_scheme.text_color+"',text_format='"+
            color_scheme.text_format+"',background_color='"+color_scheme.background_color+
            "',active_criteria='"+color_scheme.active_criteria+"',overwrite_prompt='"+
            color_scheme.overwrite_prompt+"' WHERE id = '"+color_scheme.id.to_s+"'")
    end

    def self.update(id,prop,val)
        stmt = "UPDATE color_schemes SET "+prop+"='"+val+"' WHERE id = '"+id.to_s+"'"
        Database.execute(stmt)
    end

    ###########################
    ## Activate Color Scheme ##
    ###########################

    def self.activate(color_key,bg_color_key,format,overwrite_prompt)
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        if translate_overwrite_prompt(overwrite_prompt)
            bash_formatted = format_bash_file_overwrite_prompt(bash_file,color_key,bg_color_key,format)
            File.open(bash_path, "w"){|file| file.puts bash_formatted }
        elsif !translate_overwrite_prompt(overwrite_prompt)
            bash_formatted = format_bash_file_no_overwrite(bash_file,color_key,bg_color_key,format)
            File.open(bash_path, "w"){|file| file.puts bash_formatted }
        else
            puts "error populating bash profile"
        end
    end

    def self.translate_overwrite_prompt(overwrite_prompt)
        boole = false
        case overwrite_prompt
        when 'n','no'
            boole = false
        when 'y','yes'
            boole = true
        when true,false
            boole = overwrite_prompt
        end
        boole
    end

    def self.translate_color_keyword(color)
        key_arr = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]
        key = ""
        if key_arr.include?(color)
            key = key_arr.index(color)
        else
            key = color
        end
        key
    end

    def self.create_PS1_string(color_key,bg_color_key,format)
        str = ""
        color = translate_color_keyword(color_key)
        bg_color = translate_color_keyword(bg_color_key)
        case color
            when 'x'
            else
                str << "\\[$(tput setaf #{color})\\]"
        end

        case bg_color
            when 'x'
            else
                str << "\\[$(tput setab #{bg_color})\\]"
        end

        case format
            when 'none'
            when 'bold'
                str << "\\[$(tput bold)\\]"
            when 'underline'
                str << "\\[$(tput smul)\\]"
        end
        str
    end

    def self.format_bash_file_overwrite_prompt(bash_file,color_key,bg_color_key,format)
        original_PS1 = /^#original_export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
        #remove setaf's and setab's from bash_file
            file_without_set_colors = bash_file.gsub(/\\\[\$\(tput seta[b,f] \d+\)\\\]/,'')
            removed_bolds = file_without_set_colors.gsub(/\\\[\$\(tput bold\)\\\]/,'')
            removed_underlines = removed_bolds.gsub(/\\\[\$\(tput smul\)\\\]/,'')
            file_without_all_set_colors = removed_underlines.gsub(/\\\[\$\(tput sgr0\)\\\]/,'')
            file_with_proper_original = file_without_all_set_colors.gsub(/^#original_export PS1\s*=\s*\"[^"]*/,"#{original_PS1}")
            formatted_PS1 = /^export PS1\s*=\s*\"[^"]*/.match(file_with_proper_original)[0]
            formatted_PS1_equals = /[^\"]*/.match(/(?<=").+/.match(formatted_PS1)[0])
        #add PS1
            bash_formatted = file_with_proper_original.gsub(/^export PS1\s*=\s*\".*\"/,
                "export PS1=\"#{create_PS1_string(color_key,bg_color_key,format)}#{formatted_PS1_equals}\"")
        bash_formatted
    end

    def self.format_bash_file_no_overwrite(bash_file,color_key,bg_color_key,format)
        #save copy of original PS1
            original_PS1 = /^#original_export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
            original_PS1_equals = /[^\"]*/.match(/(?<=").+/.match(original_PS1)[0])
        #append chosen setaf's and setab's
            bash_formatted = bash_file.gsub(/^export PS1\s*=\s*\".*\"/,
                "export PS1=\"\\\[$(tput sgr0)\\\]#{original_PS1_equals}#{create_PS1_string(color_key,bg_color_key,format)}\"")
            bash_formatted
    end

end