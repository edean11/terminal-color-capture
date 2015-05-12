class ColorScheme

    attr_accessor :name

    def self.all
        Database.execute("SELECT name FROM color_schemes").map do |row|
            color_scheme = ColorScheme.new()
            color_scheme.name = row[0]
            color_scheme
        end
    end

    def self.count
        Database.execute("SELECT count(id) from color_schemes")[0][0]
    end

    def self.name

    end
end