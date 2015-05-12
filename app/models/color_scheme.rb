class ColorScheme
    def self.count
        Database.execute("SELECT count(id) from color_schemes").first
    end
end