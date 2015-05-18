
require 'fileutils'

class BashFile

    #Create Bash

    def self.create_or_backup
        @@bash_profile = ENV['HOME'] + '/.bash_profile'
        if !File.exist?(@@bash_profile)
            new_bash_profile = File.new(ENV['HOME'] + '/.bash_profile', "w+")
            new_bash_profile.close
        elsif !File.exist?(ENV['HOME'] + '/.bash_profile_bak')
            #create backup bash profile, just in case
            FileUtils.cp(ENV['HOME'] + '/.bash_profile', ENV['HOME'] + '/.bash_profile_bak')
        end
    end

    #Prepare Bash

    def self.copy_PS1(bash_file,bash_path)
        bash_path = ENV['HOME'] + '/.bash_profile'
        existing_PS1 = /^export PS1\s*=\s*\"[^"]*/.match(bash_file)[0]
        bash_with_copy = bash_file.gsub(/^export PS1\s*=\s*\".*\"/,
                "#{existing_PS1}\"\n\n#original_#{existing_PS1}\"")
        bash_with_copy
    end

    def self.prepare
        create_or_backup()
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        new_bash = ""
        #create and/or copy PS1 variable
        if (bash_file.include? "export PS1")
            new_bash = copy_PS1(bash_file,bash_path)
        else
            str = "export PS1=\"\s-\v\$ \"\n"
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{str}" }
            new_bash = copy_PS1(bash_file,bash_path)
        end
        #create COLOR alias
        c_string="alias COLOR=\"~/Desktop/Code/NSS/ruby_projects/terminal-color-capture/terminal_color_capture"+
            ";. ~/.bash_profile\""
        File.open(bash_path, "w") {|file| file.puts "#{new_bash}\n\n#{c_string}" }
    end

end

