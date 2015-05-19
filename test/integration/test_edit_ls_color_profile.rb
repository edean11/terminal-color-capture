require_relative '../helper'

class EditExistingLSColorProfileTest < MiniTest::Test

    def test_no_schemes_error
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
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
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_color_scheme_chosen
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
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
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
            pipe.puts "test"
            expected << "Which ls property would you like to edit?\n"
            pipe.puts "clavicle"
            expected << "You must choose one of [name, NAME, Name, directories, DIRECTORIES, Directories, "+
            "symbolic links, SYMBOLIC LINKS, Symbolic links, sockets, SOCKETS, Sockets, pipes, PIPES, Pipes, "+
            "executables, EXECUTABLES, Executables, block specials, BLOCK SPECIALS, Block specials, "+
            "character specials, CHARACTER SPECIALS, Character specials, executables with setuid bit sets, "+
            "EXECUTABLES WITH SETUID BIT SETS, Executables with setuid bit sets, executables with setgid bit sets, "+
            "EXECUTABLES WITH SETGID BIT SETS, Executables with setgid bit sets, directories writable to others, with sticky bit, "+
            "DIRECTORIES WRITABLE TO OTHERS, WITH STICKY BIT, Directories writable to others, with sticky bit, "+
            "directories writable to others, without sticky bit, DIRECTORIES WRITABLE TO OTHERS, WITHOUT STICKY BIT, "+
            "Directories writable to others, without sticky bit].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_correct_question_asked
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
            pipe.puts "test"
            expected << "Which ls property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_invalid_question_response
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
            pipe.puts "test"
            expected << "Which ls property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts ""
            expected << "You must enter a name for this ls color profile.\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_change_in_db
        shell_output = ""
        expected = ""
        ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
        LSColorProfileController.new.add(ls_color_profile1)
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << menu_prompt
            pipe.puts "7"
            expected << "="*62+"\n"
            expected << "LS COLOR PROFILES".center(62)+"\n"
            expected << "="*62+"\n"
            expected << "NAME".center(30)+"KEY STRING".center(30)+"\n"
            expected << "-"*62+"\n"
            expected << "test".center(30)+"eabeCaEfgaxxbaexgxhxea".center(30)+"\n"
            expected << "="*62+"\n"
            expected << "Which ls color profile would you like to edit?\n"
            pipe.puts "test"
            expected << "Which ls property would you like to edit?\n"
            pipe.puts "name"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts "chum"
            expected << "LS Color Profile changed successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        str = "1. chum\n"
        assert_equal str,LSColorProfileController.new.index
    end

end