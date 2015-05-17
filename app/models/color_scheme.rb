require 'fileutils'

class ColorScheme

    attr_accessor :id,:name,:text_color,:text_format,
    :background_color,:active_criteria,:overwrite_prompt,:active,:created_at

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
        accepted_colors = ['black','red','green','yellow','blue','magenta','cyan','white']
        (0..255).each do |num|
            accepted_colors << num
        end
        accepted_colors
    end

    def self.validate_active_criteria
        DateTime
    end

    def self.validate_overwrite_prompt
        accepted_responses = ['y','yes','n','no']
    end

    def self.validate_existing_color_scheme_choice
        all_schemes = all()
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

    #####################
    ## Save Properties ##
    #####################

    def self.save(record,has_id)
        color_scheme = ColorScheme.new()
        if has_id
            color_scheme.id = record[0]
            color_scheme.active = record[7]
            color_scheme.created_at = record[8]
        end
        color_scheme.name = record[1]
        color_scheme.text_color = record[2]
        color_scheme.text_format = record[3]
        color_scheme.background_color = record[4]
        color_scheme.active_criteria = record[5]
        color_scheme.overwrite_prompt = record[6]

        color_scheme
    end

    ####################
    ## Get Properties ##
    ####################

    def self.get_id(name)
        Database.execute("SELECT id FROM color_schemes WHERE name = '"+name+"'")[0][0]
    end

    def self.all
        Database.execute("SELECT * FROM color_schemes").map do |row|
            save(row,true)
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

    def self.create_bash_profile_if_missing
        @@bash_profile = ENV['HOME'] + '/.bash_profile'
        if !File.exist?(@@bash_profile)
            new_bash_profile = File.new(ENV['HOME'] + '/.bash_profile', "w+")
            new_bash_profile.close
        else
        end
        #create backup bash profile, just in case
        if !File.exist?(ENV['HOME'] + '/.bash_profile_bak')
            FileUtils.cp(ENV['HOME'] + '/.bash_profile', ENV['HOME'] + '/.bash_profile_bak')
        end
    end

    def self.create_PS1_string(color_key,bg_color_key)
        str = ""
        if color_key != 'x' && bg_color_key != 'x'
            str << "\\[$(tput setaf #{color_key})\\]\\[$(tput setab #{bg_color_key})\\]"
        elsif color_key != 'x' && bg_color_key == 'x'
            str << "\\[$(tput setaf #{color_key})\\]"
        elsif color_key == 'x' && bg_color_key != 'x'
            str << "\\[$(tput setab #{bg_color_key})\\]"
        end
        str
    end

    def self.populate_bash_profile(color_key,bg_color_key,overwrite_prompt)
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        if !(bash_file.include? "export PS1") && overwrite_prompt
            str = 'export PS1="'+create_PS1_string(color_key,bg_color_key)+'\s-\v\$ "'
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{str}" }
        elsif !(bash_file.include? "export PS1") && !overwrite_prompt
            str = 'export PS1="\s-\v\$ '+create_PS1_string(color_key,bg_color_key)+'"'
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{str}" }
        elsif (bash_file.include? "export PS1") && overwrite_prompt
            existing_PS1 = /export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
            existing_PS1_equals = /(?<=").+/.match(existing_PS1)
            #remove setaf's and setab's from bash_file
                file_without_set_colors = bash_file.gsub('\\\[\$\(tput seta[b,f] \d+\)\\\]','')
                file_without_all_set_colors = file_without_set_colors.gsub('\\\[\$\(tput sgr0\)\\\]','')
                puts file_without_all_set_colors
            #add PS1
                bash_formatted = file_without_all_set_colors.gsub(/export PS1\s*=\s*\".*\"/,
                    "export PS1=\"#{create_PS1_string(color_key,bg_color_key)}#{existing_PS1_equals}\"\n\n#original_#{existing_PS1}\"")
                File.open(bash_path, "w"){|file| file.puts bash_formatted }
        elsif (bash_file.include? "export PS1") && !overwrite_prompt
            #save copy of original PS1
            existing_PS1 = /export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
            existing_PS1_equals = /(?<=").+/.match(existing_PS1)
            #format the original
                #append chosen setaf's and setab's
                bash_formatted = bash_file.gsub(/export PS1\s*=\s*\".*\"/,
                    "export PS1=\"\\\[$(tput sgr0)\\\]#{existing_PS1_equals}#{create_PS1_string(color_key,bg_color_key)}\"\n\n#original_#{existing_PS1}\"")
            File.open(bash_path, "w"){|file| file.puts bash_formatted }
        else
            puts "error populating bash profile"
        end
        system("tcc_BASHRELOAD")
    end

end