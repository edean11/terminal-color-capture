require 'sqlite3'

class Database

    def self.create_create_color_schemes_table
        Database.execute("CREATE TABLE IF NOT EXISTS color_schemes"+
                "(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL,"+
                " text_color varchar(12), text_format varchar(12),"+
                " background_color varchar(12), active_criteria varchar(60), overwrite_prompt integer"+
                ",active varchar(20) DEFAULT 'false', created_at varchar(20) DEFAULT CURRENT_TIMESTAMP)")
    end

    def self.create_color_scheme_restrictions_table
        Database.execute("CREATE TABLE IF NOT EXISTS color_scheme_restrictions"+
            "(id integer PRIMARY KEY AUTOINCREMENT, color_scheme_id int, restriction varchar(60))")
    end

    def self.create_ls_color_profile_tables
        Database.execute("CREATE TABLE IF NOT EXISTS ls_color_profiles"+
            "(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL,"+
            "text_color varchar(12), text_format varchar(12), background_color varchar(12)"+
            ", active varchar(20) DEFAULT 'false', created_at varchar(20) DEFAULT CURRENT_TIMESTAMP)")
    end

    def self.load_structure
        create_create_color_schemes_table()
        create_color_scheme_restrictions_table()
        create_ls_color_profile_tables()
    end

    def self.execute(*args)
        initialize_database unless defined?(@@db)
        @@db.execute(*args)
    end

    def self.initialize_database
        environment = ENV["TEST"] ? "test" : "production"
        database = "db/terminal_color_capture_#{environment}.sqlite"
        @@db = SQLite3::Database.new(database)
    end
end