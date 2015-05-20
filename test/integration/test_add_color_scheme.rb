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

    def test_blank_new_color_scheme_name
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
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
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "Zurple"
            expected << "You must choose one of [x, black, red, green, yellow, blue, magenta, cyan, white, "+
                "0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, "+
                "25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, "+
                "46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, "+
                "67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, "+
                "88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, "+
                "107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, "+
                "124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, "+
                "141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, "+
                "158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, "+
                "175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, "+
                "192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, "+
                "209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, "+
                "226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, "+
                "243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_text_format
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
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
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "cleaver"
            expected << "You must choose one of [x, black, red, green, yellow, blue, magenta, cyan, white, "+
                "0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, "+
                "25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, "+
                "46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, "+
                "67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, "+
                "88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, "+
                "107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, "+
                "124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, "+
                "141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, "+
                "158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, "+
                "175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, "+
                "192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, "+
                "209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, "+
                "226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, "+
                "243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_active_criteria_1
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "white"
            expected << "When should it begin being active? (hh:mm)\n"
            pipe.puts "whenever i say"
            expected << "You must enter a valid Time.\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_active_criteria_2
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "white"
            expected << "When should it begin being active? (hh:mm)\n"
            pipe.puts "12:00"
            expected << "When should it end? (hh:mm)\n"
            pipe.puts "whenever i say"
            expected << "You must enter a valid Time.\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_overwrite_prompt_color
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "white"
            expected << "When should it begin being active? (hh:mm)\n"
            pipe.puts "12:00"
            expected << "When should it end? (hh:mm)\n"
            pipe.puts "14:00"
            expected << "Would you like this scheme to overwrite the existing prompt color(s) for the given time period?\n"
            pipe.puts "bleh"
            expected << "You must choose one of [y, yes, n, no].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_color_scheme_success_message
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "white"
            expected << "When should it begin being active? (hh:mm)\n"
            pipe.puts "12:00"
            expected << "When should it end? (hh:mm)\n"
            pipe.puts "14:00"
            expected << "Would you like this scheme to overwrite the existing prompt color(s) for the given time period?\n"
            pipe.puts "y"
            expected << "New color scheme created successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_color_scheme_db_record_creation
        shell_output = ""
        expected = ""
        original_db_size = ColorScheme.count.to_i
        new_db_size = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "1"
            expected << "What would you like to call this color scheme?\n"
            pipe.puts "Test"
            expected << "What color text would you like it to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What format would you like it to have? (i.e. none, bold)\n"
            pipe.puts "none"
            expected << "What background color would you like?(use 'x' for default)\n"
            pipe.puts "white"
            expected << "When should it begin being active? (hh:mm)\n"
            pipe.puts "12:00"
            expected << "When should it end? (hh:mm)\n"
            pipe.puts "14:00"
            expected << "Would you like this scheme to overwrite the existing prompt color(s) for the given time period?\n"
            pipe.puts "y"
            expected << "New color scheme created successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        new_db_size = ColorScheme.count.to_i
        assert_equal original_db_size+1,new_db_size
    end

end