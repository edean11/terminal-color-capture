require_relative '../helper'


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
            expected << menu_prompt
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

end