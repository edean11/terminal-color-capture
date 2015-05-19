require_relative '../helper'

class DeleteExistingLSColorProfileTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "8"
            expected << "No ls color profiles found. Add an ls color profile.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_initial_table_output_with_schemes
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "8"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to delete?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_name_chosen
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "8"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to delete?\n"
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
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "8"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to delete?\n"
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
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "8"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to delete?\n"
            pipe.puts "test"
            expected << "Are you sure?  "
            pipe.puts "yes"
            expected << "ls color profile deleted successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        str = "No ls color profiles found. Add an ls color profile.\n"
        assert_equal str,LSColorProfileController.new.index
    end

end