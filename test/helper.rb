require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'sqlite3'
Dir["./app/**/*.rb"].each{|f| require f}
Dir["./lib/*.rb"].each{|f| require f}

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

def createColorSchemesTable
    @db.execute("CREATE TABLE IF NOT EXISTS color_schemes(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL, text_color varchar(12), text_format varchar(12), background_color varchar(12))")
end

def createColorSchemeRestrictionsTable
    @db.execute("CREATE TABLE IF NOT EXISTS color_scheme_restrictions(id integer PRIMARY KEY AUTOINCREMENT, color_scheme_id int, restriction varchar(60))")
end

def createLSColorProfilesTable
    @db.execute("CREATE TABLE IF NOT EXISTS ls_color_profiles(id integer PRIMARY KEY AUTOINCREMENT, name varchar(30) NOT NULL, text_color varchar(12), text_format varchar(12), background_color varchar(12))")
end

def setupDatabase
    @db = SQLite3::Database.new("db/terminal_color_capture_test.sqlite")
    createColorSchemesTable()
    createColorSchemeRestrictionsTable()
end

def createColorScheme(name,text_color,text_format,background_color)
    @db.execute("INSERT into color_schemes (name,text_color,text_format,background_color) VALUES (?,?,?,?)",[name,text_color,text_format,background_color])
end

def createColorSchemeRestriction(color_scheme_id,restriction)
    @db.execute("INSERT into color_scheme_restrictions (color_scheme_id,restriction) VALUES (?,?)",[color_scheme_id,restriction])
end

def menu_prompt
    "1. CreateANewColorScheme\n"+
    "2. ActivateExistingColorSchemes\n"+
    "3. EditExistingColorScheme\n"+
    "4. DeleteExistingColorScheme\n"+
    "5. CreateLSColorProfile\n"+
    "6. ChangeLSColorProfile\n"+
    "7. DeleteLSColorProfile\n"+
    "8. Exit\n"+
    "Hello, what would you like to do?\n"
end

# directory_color,symbolic_link_color,socket_color,pipe_color,executable_color,block_special_color,character_special_color,
# executable_setuid_color,executable_setguid_color,others_directory_color,others_directory_sticky_color