require 'highline/import'

class LSColorProfileController
    def index
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

    def table
        columns = 6
        table_length = 114
        column_length = table_length/columns
        extra_length = 10
        str = ""
        if ColorScheme.count > 0
            all_schemes = ColorScheme.all
            str << "="*(table_length+extra_length)+"\n"
            str << "COLOR SCHEMES".center(table_length+extra_length)+"\n"
            str << "="*(table_length+extra_length)+"\n"
            str << "NAME".center(column_length)+"COLOR".center(column_length)+
                    "FORMAT".center(column_length)+"BG_COLOR".center(column_length)+
                    "ACTIVE_CRITERIA".center(column_length+extra_length)+"PROMPT".center(column_length)+"\n"
            str << "-"*(table_length+extra_length)+"\n"
            all_schemes.each_with_index do |color_scheme, index|
                str << color_scheme.name.center(column_length)+
                    color_scheme.text_color.center(column_length)+
                    color_scheme.text_format.center(column_length)+
                    color_scheme.background_color.center(column_length)+
                    color_scheme.active_criteria.center(column_length+extra_length)+
                    color_scheme.overwrite_prompt.center(column_length)+"\n"
                str << "-"*(table_length+extra_length)+"\n" if index != all_schemes.length-1
            end
            str << "="*(table_length+extra_length)+"\n"
        else
            str << "No color schemes found. Add a color scheme.\n"
        end
        str
    end

    def add(color_scheme)
        ColorScheme.create(color_scheme.name,color_scheme.text_color,
            color_scheme.text_format,color_scheme.background_color,
            color_scheme.active_criteria,color_scheme.overwrite_prompt)
    end
end