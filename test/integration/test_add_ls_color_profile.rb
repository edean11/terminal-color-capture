require_relative '../helper'

class CreateLSColorProfileTest < MiniTest::Test

    def test_blank_new_color_ls_color_profile_name
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "5"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts ""
            expected << "You must enter a name for this ls color profile.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_ls_text_color
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "5"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts "Test"
            expected << "What text color,format,background color would you like for directories?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "Zurple,342,$#"
            expected << "You must enter a comma or space separated list with the format text_color,format,background_color\n"+
                    "Colors: [x,black,red,green,brown,blue,magenta,cyan,lightgrey] Formats: [none,bold]\n"
            expected << "What text color,format,background color would you like for directories?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_ls_color_profile_success_message
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "5"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts "Test"
            expected << "What text color,format,background color would you like for directories?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "blue,none,red"
            expected << "What text color,format,background color would you like for symbolic links?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "red,none,blue"
            expected << "What text color,format,background color would you like for sockets?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "blue,none,red"
            expected << "What text color,format,background color would you like for pipes?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "blue,none,red"
            expected << "What text color,format,background color would you like for executables?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "black,none,red"
            expected << "What text color,format,background color would you like for block specials?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "x,none,red"
            expected << "What text color,format,background color would you like for character specials?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "magenta,bold,red"
            expected << "What text color,format,background color would you like for executables with setuid bit sets?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "x,none,red"
            expected << "What text color,format,background color would you like for executables with setgid bit sets?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "cyan,none,red"
            expected << "What text color,format,background color would you like for directories writable to others, with sticky bit?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "x,none,red"
            expected << "What text color,format,background color would you like for directories writable to others, without sticky bit?\n"+
            "Use 'x' for default. Enter comma or space separated list.\n"
            pipe.puts "lightgrey,none,red"
            expected << "New ls color profile created successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

end