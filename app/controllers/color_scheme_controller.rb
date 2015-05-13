require 'highline/import'

class ColorSchemeController
    def self.index
        str = ""
        if ColorScheme.count > 0
            color_schemes = ColorScheme.all
            color_schemes.each_with_index do |color_scheme,index|
                str << "#{index+1}. #{color_scheme.name}\n"
            end
        else
            str << "No color schemes found. Add a color scheme.\n"
        end
        str
    end

    def self.table
        @@table_length = 105
        str = ""
        if ColorScheme.count > 0
            all_schemes = ColorScheme.all
            str << "="*@@table_length+"\n"
            str << "COLOR SCHEMES".center(@@table_length)+"\n"
            str << "="*@@table_length+"\n"
            str << "NAME".center(15)+"COLOR".center(15)+"FORMAT".center(15)+
                        "BG_COLOR".center(15)+"ACTIVE".center(15)+"PROMPT".center(15)+"\n"
            str << "-"*@@table_length+"\n"
            all_schemes.each_with_index do |color_scheme, index|
                str << color_scheme.name.center(15)+color_scheme.text_color.center(15)+
                    color_scheme.text_format.center(15)+color_scheme.background_color.center(15)+
                    color_scheme.active_criteria.center(15)+color_scheme.overwrite_prompt.center(15)+"\n"

                str << "-"*@@table_length+"\n" if index != all_schemes.length-1
            end
            str << "="*@@table_length+"\n"
        else
            str << index
        end
        str
    end

    def self.add(name,text_color,text_format,background_color,active_criteria,overwrite_prompt)
        ColorScheme.create(name,text_color,text_format,background_color,
            active_criteria,overwrite_prompt)
    end
end