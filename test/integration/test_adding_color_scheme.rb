require_relative '../helper'

### Create a new color scheme

#   > ./terminal_color_scheme
#   > `Menu
#     1. Create a New Color Scheme
#     2. View an Existing Color Scheme
#     3. Edit an Existing Color Scheme
#     4. Delete an Existing Color Scheme`
#   > `1`
#   > `What would you like to call this color scheme?:
#   >  `[SchemeName]`
#   > `What color text would you like it to have?`
#   > `[TextColor]`
#   > `What format would you like it to have? (i.e. none, bold, underline)`
#   > `[TextFormat]`
#   > `What background color would you like?`
#   > `[BackgroundColor]`
#   > `When would you like this scheme to be active (hh:mm mm/dd/yy)`
#   > `[ActiveCriteria]`
#   1. Creates a new color scheme record in db and returns success
#   > `New color scheme created successfully!`
#   > `exit`
#   2. Exits the program

# Acceptance Criteria:

#   * New color scheme added to proper tables
#   * Error returned if ActiveCriteria overlaps an existing ActiveCriteria
#   * Calling `exit` exits the program

class CreateANewColorSchemeTest < MiniTest::Test

    $menu_prompt = <<EOS
1. CreateANewColorScheme
2. ActivateExistingColorSchemes
3. EditExistingColorScheme
4. DeleteExistingColorScheme
5. CreateLSColorProfile
6. ChangeLSColorProfile
7. DeleteLSColorProfile
Hello, what would you like to do?
EOS

    def test_invalid_menu_choice
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "21"
            string = <<EOS
You must choose one of [1, 2, 3, 4, 5, 6, 7, CreateANewColorScheme, ActivateExistingColorSchemes, EditExistingColorScheme, DeleteExistingColorScheme, CreateLSColorProfile, ChangeLSColorProfile, DeleteLSColorProfile].
?
EOS
            expected << string.chomp + '  '
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_blank_new_color_scheme_name
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts ""
            expected << "You must enter a name for this color scheme.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_text_color
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?\n"
            pipe.puts "Zurple"
            expected << "You must choose one of [red, blue, green, yellow, black, white, orange, purple].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_text_format
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "striking through it"
            expected << "You must choose one of [none, bold, underline].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_background_color
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?\n"
            pipe.puts "cleaver"
            expected << "You must choose one of [red, blue, green, yellow, black, white, orange, purple].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_active_criteria
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?\n"
            pipe.puts "white"
            expected << "When would you like this scheme to be active? (hh:mm-hh:mm)\n"
            pipe.puts "whenever i say"
            expected << "You must enter a valid DateTime.\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_color_scheme_success_message
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?\n"
            pipe.puts "white"
            expected << "When would you like this scheme to be active? (hh:mm-hh:mm)\n"
            pipe.puts "12:00-23:00"
            expected << "New color scheme created successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

end