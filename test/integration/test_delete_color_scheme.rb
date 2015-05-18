require_relative '../helper'

### Delete Existing Color Scheme

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

#   > 4
# ```
#   Program outputs all color schemes in the database and returns formatted data
# ```
#   > Which scheme would you like to delete?
#   > [SchemeName]
#   > Delete [SchemeName]?
#   > y
# ```
#   The program deletes the desired color scheme
# ```
#   > exit
# ```
#   Exits the program

# Acceptance Criteria:

#   * Program deletes the given color scheme
#   * Returns to menu when finished

class DeleteExistingColorSchemeTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "4"
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
            pipe.puts "4"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to delete?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_name_chosen
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "4"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to delete?\n"
            pipe.puts "bleh"
            expected << "You must choose one of [test].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_confirmation_question
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "4"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to delete?\n"
            pipe.puts "test"
            expected << "Are you sure?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_delete_chosen_item_from_db
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "4"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to delete?\n"
            pipe.puts "test"
            expected << "Are you sure?  "
            pipe.puts "yes"
            expected << "Color scheme deleted successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        str = "No color schemes found. Add a color scheme.\n"
        assert_equal str,ColorSchemeController.index
    end

end