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
        ask("Which ls color profile would you like to edit?",
            LSColorProfile.validate_existing_ls_color_profile_choice){|q|
        }
    end

    def self.ask_which_property_change
        ask("Which ls property would you like to edit?",
            LSColorProfile.validate_ls_color_profile_property_choice){|q|
        }
    end

    def self.ask_chosen_property_question(prop)
        val = []
        val[0] = prop.downcase
        if val[0] == 'name'
            val[1] = ask("What would you like to call this LS Color Profile?",
                String){|scheme_name|
            }
            if val[1].empty?
                say("You must enter a name for this ls color profile.\n")
                exit
            end
        else
            val[1] = ask("What text color,format,background color would you like for #{val[0]}?\n"+
                "Use 'x' for default. Enter comma or space separated list.")
            LSColorProfile.validate_ls_input(val[1])
        end
        val
    end

    def self.ask_all_change_ls_color_profile
        id = ""
        ls_color_profile = ask_which_ls_color_profile_change
        id = LSColorProfile.get_id(ls_color_profile)
        property_unformatted = ask_which_property_change
        val_arr = ask_chosen_property_question(property_unformatted)
        start_ind = LSColorProfile.find_property_key_string_index(val_arr[0])
        val = val_arr[1]
        new_key_string = ""
        if val_arr[0] == 'name'
            new_key_string = val
        else
            first_answer = val.partition(/\s*[,\s]\s*/)[0]
            last_answers = (val.partition(/\s*[,\s]\s*/)[2]).partition(/\s*[,\s]\s*/)
            second_answer = last_answers[0]
            third_answer = last_answers[2]
            key_string_arr = [first_answer,second_answer,third_answer]
            new_key_string = LSColorProfile.find_color_keys(key_string_arr)
        end
        say("Color scheme changed successfully!\n")
        [id,start_ind,new_key_string]
    end

    #############################
    ## Delete LS Color Profile ##
    #############################

    def self.ask_which_ls_color_profile_delete
        validation_arr = LSColorProfile.all.map{|ls_color_profile| ls_color_profile.name}
        ask("Which ls color profile would you like to delete?",
            validation_arr){|q|
            q.confirm = true
        }
    end
end