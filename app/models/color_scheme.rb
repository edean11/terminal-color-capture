class ColorScheme

    attr_accessor :id,:name,:text_color,:text_format,
    :background_color,:active_criteria,:overwrite_prompt

    def self.save(record,insert_id)
        color_scheme = ColorScheme.new()
        color_scheme.id = record[0] if insert_id
        color_scheme.name = record[1]
        color_scheme.text_color = record[2]
        color_scheme.text_format = record[3]
        color_scheme.background_color = record[4]
        color_scheme.active_criteria = record[5]
        color_scheme.overwrite_prompt = record[6]
        color_scheme
    end

    def self.all
        Database.execute("SELECT * FROM color_schemes").map do |row|
            save(row,true)
        end
    end

    def self.count
        Database.execute("SELECT count(id) from color_schemes")[0][0]
    end

    def self.create(name,text_color,text_format,background_color,active_criteria,overwrite_prompt)
        Database.execute("INSERT into color_schemes (name,text_color,text_format,background_color,active_criteria,overwrite_prompt) VALUES (?,?,?,?,?,?)",
            [name,text_color,text_format,background_color,active_criteria,overwrite_prompt])
    end

    def self.delete(id)
        Database.execute("DELETE FROM color_schemes WHERE id = '"+id.to_s+"'")
    end

    def self.update(id,name,text_color,text_format,background_color,active_criteria,overwrite_prompt)
        Database.execute("UPDATE color_schemes SET name='"+name+"',text_color='"+text_color+
            "',text_format='"+text_format+"',background_color='"+background_color+
            "',active_criteria='"+active_criteria+"',overwrite_prompt='"+overwrite_prompt+
            "' WHERE id = '"+id.to_s+"'")
    end

    def self.get_id(name)
        Database.execute("SELECT id FROM color_schemes WHERE name = '"+name+"'")[0][0]
    end
end