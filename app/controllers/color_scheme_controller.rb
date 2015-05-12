class ColorSchemeController
    def index
        if ColorScheme.count > 0
            color_schemes = ColorScheme.all
            color_schemes.each_with_index do |scenario,index|
                say("#{index+1}. #{color_scheme.name}")
            end
        else
            say("No color schemes found. Add a color scheme.\n")
        end
    end
end