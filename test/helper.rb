require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'sqlite3'
Dir["./app/**/*.rb"].each{|f| require f}
Dir["./lib/*.rb"].each{|f| require f}
ENV["TEST"] = "true"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

class Minitest::Test
    def setup
        Database.load_structure
        Database.execute("DELETE FROM color_schemes")
        Database.execute("DELETE FROM color_scheme_restrictions")
        Database.execute("DELETE FROM ls_color_profiles")
    end
end

def createColorSchemeRestriction(color_scheme_id,restriction)
    Database.execute("INSERT into color_scheme_restrictions (color_scheme_id,restriction) VALUES (?,?)",[color_scheme_id,restriction])
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