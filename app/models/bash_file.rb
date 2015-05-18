
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

    def self.create_new_bash_file(bash_file,bash_path)
        new_bash = ""
        if (bash_file.include? "original_export PS1")
        elsif (bash_file.include? "export PS1")
            new_bash = copy_PS1(bash_file,bash_path)
        else
            str = "export PS1=\"\s-\v\$ \"\n"
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}\n\n#{str}" }
            new_bash = copy_PS1(bash_file,bash_path)
        end
        new_bash
    end

    def self.prepare
        create_or_backup()
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        new_bash = create_new_bash_file(bash_file,bash_path)
        #create BASH_RELOAD alias
        bash_reload = "\n\nalias BASH_RELOAD=\". ~/.bash_profile\""
        #create COLOR alias
        cwd = Dir.getwd
        c_string="\n\nalias COLOR=\"#{cwd}/activate;"+
            ". ~/.bash_profile\""
        if !(bash_file.include? "original_export PS1") && !(bash_file.include? "alias COLOR")
            File.open(bash_path, "w") {|file| file.puts "#{new_bash}#{bash_reload}#{c_string}" }
        elsif !(bash_file.include? "original_export PS1")
            File.open(bash_path, "w") {|file| file.puts "#{new_bash}" }
        elsif !(bash_file.include? "alias COLOR")
            File.open(bash_path, "w") {|file| file.puts "#{bash_file}#{bash_reload}#{c_string}" }
        end
    end

    def self.default
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        default_PS1 = /^#original_export\s*PS1\s*=\s*\".*\"/.match(bash_file)[0]
        default_formatted_PS1 = /export\s*PS1\s*=\s*\".*\"/.match(default_PS1)[0]
        default_formatted = bash_file.gsub(/^export PS1\s*=\s*\".*\"/,default_formatted_PS1)
        File.open(bash_path, "w") {|file| file.puts "#{default_formatted}" }
    end

end

