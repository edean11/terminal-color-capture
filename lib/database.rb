require 'sqlite3'

class Database

    def self.create_color_schemes_table
        Database.execute("CREATE TABLE IF NOT EXISTS color_schemes"+
                "(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL,"+
                " text_color varchar(12), text_format varchar(12),"+
                " background_color varchar(12), active_criteria varchar(60), overwrite_prompt integer"+
                ",active varchar(10) DEFAULT 'false', created_at varchar(30) DEFAULT CURRENT_TIMESTAMP)")
    end

    def self.create_ls_color_profile_tables
        Database.execute("CREATE TABLE IF NOT EXISTS ls_color_profiles"+
            "(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL,"+
            "dir_color varchar(12), dir_format varchar(12), dir_bg_color varchar(12),"+
            "sym_color varchar(12), sym_format varchar(12), sym_bg_color varchar(12),"+
            "soc_color varchar(12), soc_format varchar(12), soc_bg_color varchar(12),"+
            "pipe_color varchar(12), pipe_format varchar(12), pipe_bg_color varchar(12),"+
            "exec_color varchar(12), exec_format varchar(12), exec_bg_color varchar(12),"+
            "block_color varchar(12), block_format varchar(12), block_bg_color varchar(12),"+
            "char_color varchar(12), char_format varchar(12), char_bg_color varchar(12),"+
            "execuid_color varchar(12), execuid_format varchar(12), execuid_bg_color varchar(12),"+
            "execgid_color varchar(12), execgid_format varchar(12), execgid_bg_color varchar(12),"+
            "dir_sticky_color varchar(12), dir_sticky_format varchar(12), dir_sticky_bg_color varchar(12),"+
            "dir_nosticky_color varchar(12), dir_nosticky_format varchar(12), dir_nosticky_bg_color varchar(12),"+
            "active varchar(20) DEFAULT 'false', created_at varchar(20) DEFAULT CURRENT_TIMESTAMP)")
    end

    def self.load_structure
        create_color_schemes_table()
        #create_color_scheme_restrictions_table()
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