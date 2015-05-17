
require 'fileutils'

class Bash

    #Create Bash

    def self.create_or_backup
        @@bash_profile = ENV['HOME'] + '/.bash_profile'
        if !File.exist?(@@bash_profile)
            new_bash_profile = File.new(ENV['HOME'] + '/.bash_profile', "w+")
            new_bash_profile.close
        else
            #create backup bash profile, just in case
            FileUtils.cp(ENV['HOME'] + '/.bash_profile', ENV['HOME'] + '/.bash_profile_bak')
        end
    end

    #Prepare Bash

    def self.copy_PS1(bash_file)
        bash_path = ENV['HOME'] + '/.bash_profile'
        existing_PS1 = /^export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
        bash_with_copy = bash_file.gsub(/^export PS1\s*=\s*\".*\"/,
                "#{existing_PS1}\"\n\n#original_#{existing_PS1}\"")
        File.open(bash_path, "w"){|file| file.puts bash_with_copy }
    end

    def self.prepare
        create_or_backup()
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        #create and/or copy PS1 variable
        if (bash_file.include? "export PS1")
            copy_PS1(bash_file)
        else
            str = "export PS1=\"\s-\v\$ \"\n"
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{str}" }
            copy_PS1(bash_file)
        end
        #create TCC_BASHRELOAD alias
        BR_string = "alias TCC_BASHRELOAD=\". ~/.bash_profile\""
        File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{BR_string}" }
        #create COLOR alias
        C_string = "alias COLOR=\"~/Desktop/Code/NSS/ruby_projects/terminal-color-capture/terminal_color_capture"+
            ";. ~/.bash_profile\""
        File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{C_string}" }
    end

end

