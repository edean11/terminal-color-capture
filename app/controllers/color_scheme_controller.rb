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
end