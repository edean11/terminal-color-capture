require 'highline/import'

class LSColorProfileQuestionsController

    ################################
    ## LS Color Profile Questions ##
    ################################

    def self.ask_ls_name
        ask("What would you like to call this LS Color Profile?",
        String){|scheme_name|
        }
    end

    ##########################
    ## New LS Color Profile ##
    ##########################

    def self.ask_all_new_ls_profile
        name = ask_ls_name
        if name.empty?
            say("You must enter a name for this ls color profile.\n")
            exit
        end
        key_arr = ['directories','symbolic links','sockets','pipes','executables','block specials',
            'character specials','executables with setuid bit sets','executables with setgid bit sets',
            'directories writable to others, with sticky bit','directories writable to others, without sticky bit']
        val_arr = [nil,name]
        key_arr.each do |ls_type|
            answer = ask("What text color,format,background color would you like for #{ls_type}?\n"+
                "Use 'x' for default. Enter comma or space separated list.")
            while LSColorProfile.validate_ls_input(answer) == false
                say("You must enter a comma or space separated list with the format text_color,format,background_color\n"+
                    "Colors: [x,black,red,green,brown,blue,magenta,cyan,lightgrey] Formats: [none,bold]")
                answer = ask("What text color,format,background color would you like for #{ls_type}?\n"+
                "Use 'x' for default. Enter comma or space separated list.")
            end
            first_answer = answer.partition(/\s*[,\s]\s*/)[0]
            last_answers = (answer.partition(/\s*[,\s]\s*/)[2]).partition(/\s*[,\s]\s*/)
            second_answer = last_answers[0]
            third_answer = last_answers[2]
            val_arr << first_answer
            val_arr << second_answer
            val_arr << third_answer
        end
        val_arr
    end

    ###############################
    ## Activate LS Color Profile ##
    ###############################

    def self.ask_which_ls_color_profile_activate
        validation_arr = LSColorProfile.all.map{|ls_profile| ls_profile.name}
        ask("Which color scheme would you like to temporarily activate?",
            validation_arr){|q|
            q.confirm = true
        }
    end

    ###########################
    ## Edit LS Color Profile ##
    ###########################

    def self.ask_which_ls_color_profile_change
        ask("Which color scheme would you like to edit?",
            LSColorProfile.validate_existing_ls_color_profile_choice){|q|
        }
    end

    def self.ask_which_property_change
        ask("Which property would you like to edit?",
            LSColorProfile.validate_ls_color_profile_property_choice){|q|
        }
    end

    def self.ask_chosen_property_question(prop)
        val = []
        case prop
            when 'name','NAME'
                val[0] = 'name'
                val[1] = ask_name()
                if val[1].empty?
                    say("You must enter a name for this color scheme.\n")
                    exit 0
                end
            when 'text color','COLOR','color'
                val[0] = 'text_color'
                val[1] = ask_text_color()
            when 'text format','FORMAT','format'
                val[0] = 'text_format'
                val[1] = ask_text_format()
            when 'background color','BG_COLOR','bg_color'
                val[0] = 'background_color'
                val[1] = ask_background_color()
            when 'active criteria','ACTIVE CRITERIA','ACTIVE_CRITERIA'
                val[0] = 'active_criteria'
                val[1] = ask_active_criteria()
            when 'overwrite prompt','PROMPT','prompt'
                val[0] = 'overwrite_prompt'
                val[1] = ask_overwrite_prompt()
        end
        val
    end

    def self.ask_all_change_scheme
        id = ""
        ls_color_profile = ask_which_ls_color_profile_change
        id = LSColorProfile.get_id(ls_color_profile)
        property_unformatted = ask_which_property_change
        val_arr = ask_chosen_property_question(property_unformatted)
        property = val_arr[0]
        val = val_arr[1]
        say("Color scheme changed successfully!\n")
        [id,property,val]
    end

    #############################
    ## Delete LS Color Profile ##
    #############################

    def self.ask_which_ls_color_profile_delete
        validation_arr = LSColorProfile.all.map{|ls_color_profile| ls_color_profile.name}
        ask("Which color scheme would you like to delete?",
            validation_arr){|q|
            q.confirm = true
        }
    end
end