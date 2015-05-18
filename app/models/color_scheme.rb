require 'Date'


class ColorScheme

    attr_accessor :record,:id,:name,:text_color,:text_format,
    :background_color,:active_criteria,:overwrite_prompt,:active,:created_at

    ################
    ## Validation ##
    ################

    def validate_name
        String
    end

    def validate_format
        accepted_formats = ['none','bold','underline']
    end

    def validate_color
        accepted_colors = ['black','red','green','yellow','blue','magenta','cyan','white']
        (0..255).each do |num|
            accepted_colors << num
        end
        accepted_colors
    end

    def validate_active_criteria
        Time
    end

    def validate_overwrite_prompt
        accepted_responses = ['y','yes','n','no']
    end

    def validate_existing_color_scheme_choice
        all_schemes = ColorScheme.all()
        accepted_responses = []
        all_schemes.each do |color_scheme|
            accepted_responses << color_scheme.name
        end
        accepted_responses
    end

    def validate_color_scheme_property_choice
        accepted_responses = ['name','NAME','text color','COLOR','color','text format','FORMAT',
            'format','background color','BG_COLOR','bg_color','active criteria','ACTIVE_CRITERIA',
            'ACTIVE CRITERIA','overwrite prompt','PROMPT', 'prompt']
    end

    #####################
    ## Save Properties ##
    #####################

    def save(record,has_id)
        color_scheme = ColorScheme.new()
        if has_id
            color_scheme.id = record[0]
            @id = record[0]
            color_scheme.active = record[7]
            @active = record[7]
            color_scheme.created_at = record[8]
            @created_at = record[8]
        end
        color_scheme.name = record[1]
        @name = record[1]
        color_scheme.text_color = record[2]
        @text_color = record[2]
        color_scheme.text_format = record[3]
        @text_format = record[3]
        color_scheme.background_color = record[4]
        @background_color = record[4]
        color_scheme.active_criteria = record[5]
        @active_criteria = record[5]
        color_scheme.overwrite_prompt = record[6]
        @active_criteria = record[6]

        color_scheme
    end

    ####################
    ## Get Properties ##
    ####################

    def self.all
        Database.execute("SELECT * FROM color_schemes").map do |row|
            ColorScheme.new.save(row,true)
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
        active[0]
    end

    def self.get_id(name)
        Database.execute("SELECT id FROM color_schemes WHERE name = '"+name+"'")[0][0]
    end

    #needs testing##
    def self.match_prop(prop,val)
        Database.execute("SELECT * FROM color_schemes WHERE "+prop+" = '"+val+"'").map do |row|
            ColorScheme.new.save(row,true)
        end
    end

    def self.get_props(id)
        Database.execute("SELECT * FROM color_schemes WHERE id = '"+id+"'").map do |row|
            ColorScheme.new.save(row,true)
        end
    end
    #################

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

    def self.translate_color_keyword(color)
        key_arr = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]
        key = ""
        if key_arr.include?(color)
            key << key_arr.index(color)
        else
            key << color
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
                str << "\\[$(tput setaf #{color_key})\\]"
        end

        case bg_color
            when 'x'
            else
                str << "\\[$(tput setab #{bg_color_key})\\]"
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
        original_PS1_equals = /[^\"]*/.match(/(?<=").+/.match(original_PS1)[0])
        #remove setaf's and setab's from bash_file
            file_without_set_colors = bash_file.gsub('\\\[\$\(tput seta[b,f] \d+\)\\\]','')
            file_without_all_set_colors = file_without_set_colors.gsub('\\\[\$\(tput sgr0\)\\\]','')
            puts file_without_all_set_colors
        #add PS1
            bash_formatted = file_without_all_set_colors.gsub(/^export PS1\s*=\s*\".*\"/,
                "export PS1=\"#{create_PS1_string(color_key,bg_color_key,format)}#{original_PS1_equals}\"")
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

    def self.activate(color_key,bg_color_key,format,overwrite_prompt)
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        if overwrite_prompt
            bash_formatted = format_bash_file_overwrite_prompt(bash_file,color_key,bg_color_key,format)
            File.open(bash_path, "w"){|file| file.puts bash_formatted }
        elsif !overwrite_prompt
            bash_formatted = format_bash_file_no_overwrite(bash_file,color_key,bg_color_key,format)
            File.open(bash_path, "w"){|file| file.puts bash_formatted }
        else
            puts "error populating bash profile"
        end
        system("tcc_BASHRELOAD")
    end

end