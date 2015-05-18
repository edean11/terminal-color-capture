require_relative '../helper'

class BasicUsageTest < MiniTest::Test

    def test_invalid_menu_choice
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "21"
            string = "You must choose one of [1, 2, 3, 4, 5, 6, 7, 8, 9, "+
            "CreateANewColorScheme, ActivateExistingColorScheme, EditExistingColorScheme, "+
            "DeleteExistingColorScheme, CreateLSColorProfile, ActivateLSColorProfile, EditLSColorProfile, "+
            "DeleteLSColorProfile, Exit].\n?"
            expected << string.chomp + '  '
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end
end