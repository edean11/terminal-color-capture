require_relative '../helper'

### Edit Existing Color Scheme

# Usage Example:

# ```
#   > ./terminal_color_scheme
#   > Menu
#     1. CreateANewColorScheme
#     2. ActivateExistingColorSchemes
#     3. EditExistingColorScheme
#     4. DeleteExistingColorScheme
#     5. CreateLSColorProfile
#     6. ChangeLSColorProfile
#     7. DeleteLSColorProfile
#     8. Exit

#   > 3
# ```
#   Program outputs all color schemes in the database and returns formatted data
# ```
#   > Which scheme would you like to edit?
#   > [SchemeName]
#   > What color text would you like it to have?
#   > [TextColor]
#   > What format would you like it to have? (i.e. none, bold, underline)
#   > [TextFormat]
#   > What background color would you like?
#   > [BackgroundColor]
# ```
#   The program updates the color scheme accordingly

# Acceptance Criteria:

#   * Program changes the existing color scheme
#   * Returns to menu when finished

class EditExistingColorSchemeTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "No color schemes found. Add a color scheme.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_initial_table_output_with_schemes
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_color_scheme_chosen
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.puts "bdash"
            expected << "You must choose one of [test].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_color_scheme_property_chosen
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.puts "test"
            expected << "Which property would you like to edit?\n"
            pipe.puts "clavicle"
            expected << "You must choose one of [name, NAME, text color, COLOR, color, text format,"+
                " FORMAT, format, background color, BG_COLOR, bg_color, active criteria, ACTIVE_CRITERIA, "+
                "ACTIVE CRITERIA, overwrite prompt, PROMPT, prompt].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_correct_question_asked
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.puts "test"
            expected << "Which property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this color scheme?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_question_response
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.puts "test"
            expected << "Which property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts ""
            expected << "You must enter a name for this color scheme.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_change_in_db
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "3"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to edit?\n"
            pipe.puts "test"
            expected << "Which property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "chum"
            expected << "Color scheme changed successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        str = "1. chum\n"
        assert_equal str,ColorSchemeController.index
    end

end