require_relative '../helper'


class ActivateExistingColorSchemeTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "2"
            expected << "No color schemes found. Add a color scheme.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_activate_color_scheme_questions
        shell_output = ""
        expected = ""
        color_scheme1 = ColorScheme.new([nil,'test','blue','none','red','11:00-23:00','true'],false)
        ColorSchemeController.new.add(color_scheme1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "2"
            expected << "="*124+"\n"
            expected << "COLOR SCHEMES".center(124)+"\n"
            expected << "="*124+"\n"
            expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                        "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
            expected << "-"*124+"\n"
            expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                        "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
            expected << "="*124+"\n"
            expected << "Which color scheme would you like to temporarily activate?\n"
            pipe.puts "dsajkh"
            expected << "You must choose one of [test].\n?  "
            pipe.puts "test"
            expected << "Are you sure?  "
            pipe.puts "y"
            expected << "Color scheme activated successfully! Use `BASH_RELOAD` to apply changes\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

end