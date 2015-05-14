require 'highline/import'

class ColorSchemeQuestionsController

    def self.ask_name
        ask("What would you like to call this color scheme?",
            String){|scheme_name|
        }
    end

    def self.ask_text_color
        ask("What color text would you like it to have?",
            accepted_colors){|q|
        }
    end

    def self.ask_text_format
        ask("What format would you like it to have? (i.e. none, bold)",
            accepted_formats){|q|
        }
    end

    def self.ask_background_color
        ask("What background color would you like?",
            accepted_colors){|q|
        }
    end

    def self.ask_active_criteria
        ask("When would you like this scheme to be active? (hh:mm-hh:mm)",
            DateTime){|q|
        }
    end

    def self.ask_overwrite_prompt
        ask("Would you like this scheme to overwrite the existing prompt color(s) for the given time period?",
            ['y','yes','n','no']){|q|
        }
    end

    def self.ask_all
        name = ask_name()
        if name.empty?
            puts "You must enter a name for this color scheme.\n"
            exit 0
        end
        text_color = ask_text_color()
        text_format = ask_text_format()
        background_color = ask_background_color()
        active_criteria = ask_active_criteria()
        overwrite_prompt = ask_overwrite_prompt()
        puts "New color scheme created successfully!\n"
        arr = [nil,name,text_color,text_format,background_color,
            active_criteria,overwrite_prompt]
    end

end




