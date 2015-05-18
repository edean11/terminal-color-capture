require 'highline/import'

class ColorSchemeQuestionsController

    ############################
    ## Color Scheme Questions ##
    ############################

    def self.ask_name
        ask("What would you like to call this color scheme?",
            ColorScheme.validate_name){|scheme_name|
        }
    end

    def self.ask_text_color
        ask("What color text would you like it to have?",
            ColorScheme.validate_color){|q|
        }
    end

    def self.ask_text_format
        ask("What format would you like it to have? (i.e. none, bold)",
            ColorScheme.validate_format){|q|
        }
    end

    def self.ask_background_color
        ask("What background color would you like?",
            ColorScheme.validate_color){|q|
        }
    end

    def self.ask_active_criteria_1
        ask("When should it begin being active? (hh:mm)",
            ColorScheme.validate_active_criteria){|q|
        }
    end

    def self.ask_active_criteria_2
        ask("When should it end? (hh:mm)",
            ColorScheme.validate_active_criteria){|q|
        }
    end

    def self.ask_active_criteria
        active_criteria_1 = ask_active_criteria_1().to_s.match(/\d\d:\d\d/)[0]
        active_criteria_2 = ask_active_criteria_2().to_s.match(/\d\d:\d\d/)[0]
        active_criteria = "#{active_criteria_1} - #{active_criteria_2}"
    end

    def self.ask_overwrite_prompt
        ask("Would you like this scheme to overwrite the existing prompt color(s) for the given time period?",
            ColorScheme.validate_overwrite_prompt){|q|
        }
    end

    ######################
    ## New Color Scheme ##
    ######################

    def self.ask_all_new_scheme
        name = ask_name()
        if name.empty?
            say("You must enter a name for this color scheme.\n")
            exit 0
        end
        text_color = ask_text_color()
        text_format = ask_text_format()
        background_color = ask_background_color()
        active_criteria = ask_active_criteria()
        overwrite_prompt = ask_overwrite_prompt()
        arr = []
        arr = [nil,name,text_color,text_format,background_color,
            active_criteria.to_s,overwrite_prompt]
        say("New color scheme created successfully!\n")
        arr
    end

    ###########################
    ## Activate Color Scheme ##
    ###########################

    def self.ask_which_color_scheme_activate
        validation_arr = ColorScheme.all.map{|color_scheme| color_scheme.name}
        ask("Which color scheme would you like to temporarily activate?",
            validation_arr){|q|
            q.confirm = true
        }
    end

    #######################
    ## Edit Color Scheme ##
    #######################

    def self.ask_which_color_scheme_change
        ask("Which color scheme would you like to edit?",
            ColorScheme.validate_existing_color_scheme_choice){|q|
        }
    end

    def self.ask_which_property_change
        ask("Which property would you like to edit?",
            ColorScheme.validate_color_scheme_property_choice){|q|
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
        color_scheme = ask_which_color_scheme_change
        id = ColorScheme.get_id(color_scheme)
        property_unformatted = ask_which_property_change
        val_arr = ask_chosen_property_question(property_unformatted)
        property = val_arr[0]
        val = val_arr[1]
        say("Color scheme changed successfully!\n")
        [id,property,val]
    end

    #########################
    ## Delete Color Scheme ##
    #########################

    def self.ask_which_color_scheme_delete
        validation_arr = ColorScheme.all.map{|color_scheme| color_scheme.name}
        ask("Which color scheme would you like to delete?",
            validation_arr){|q|
            q.confirm = true
        }
    end
end




