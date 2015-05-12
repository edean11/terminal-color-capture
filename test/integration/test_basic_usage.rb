require_relative '../helper'

class BasicUsageTest < MiniTest::Test

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
end