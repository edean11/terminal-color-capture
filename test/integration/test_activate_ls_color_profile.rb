require_relative '../helper'


class ActivateExistingLSColorProfileTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "6"
            expected << "No ls color profiles found. Add an ls color profile.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_activate_color_scheme
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "6"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to temporarily activate?\n"
            pipe.puts "dsajkh"
            expected << "You must choose one of [test].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

end