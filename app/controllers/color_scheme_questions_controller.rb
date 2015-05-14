require 'highline/import'

class ColorSchemeQuestionsController

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

    def self.ask_active_criteria
        ask("When would you like this scheme to be active? (hh:mm-hh:mm)",
            ColorScheme.validate_active_criteria){|q|
        }
    end

    def self.ask_overwrite_prompt
        ask("Would you like this scheme to overwrite the existing prompt color(s) for the given time period?",
            ColorScheme.validate_overwrite_prompt){|q|
        }
    end

    def self.ask_all
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
        say("New color scheme created successfully!\n")
        arr = [nil,name,text_color,text_format,background_color,
            active_criteria.to_s,overwrite_prompt]
        arr
    end

end




