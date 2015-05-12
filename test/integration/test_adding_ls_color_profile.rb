require_relative '../helper'

class CreateLSColorProfileTest < MiniTest::Test

    $menu_prompt = <<EOS
1. CreateANewColorScheme
2. ViewExistingColorSchemes
3. EditExistingColorScheme
4. DeleteExistingColorScheme
5. CreateLSColorProfile
6. ChangeLSColorProfile
7. DeleteLSColorProfile
Hello, what would you like to do?
EOS

    def test_blank_new_color_ls_color_profile_name
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
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
            expected << $menu_prompt
            pipe.puts "5"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts "Test"
            expected << "What color text would you like directories to have?(use 'x' for default)\n"
            pipe.puts "Zurple"
            expected << "You must choose one of [black, red, green, brown, blue, magenta, cyan, light grey, x].\n?  "
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

    def test_ls_color_profile_success_message
        shell_output = ""
        expected = ""
        IO.popen('././terminal_color_capture','r+') do |pipe|
            expected << $menu_prompt
            pipe.puts "5"
            expected << "What would you like to call this LS Color Profile?\n"
            pipe.puts "Test"
            expected << "What color text would you like directories to have?(use 'x' for default)\n"
            pipe.puts "blue"
            expected << "What color text would you like symbolic links to have?(use 'x' for default)\n"
            pipe.puts "red"
            expected << "What color text would you like sockets to have?(use 'x' for default)\n"
            pipe.puts "green"
            expected << "What color text would you like pipes to have?(use 'x' for default)\n"
            pipe.puts "brown"
            expected << "What color text would you like executables to have?(use 'x' for default)\n"
            pipe.puts "black"
            expected << "What color text would you like block specials to have?(use 'x' for default)\n"
            pipe.puts "x"
            expected << "What color text would you like character specials to have?(use 'x' for default)\n"
            pipe.puts "magenta"
            expected << "What color text would you like executables with setuid bit sets to have?(use 'x' for default)\n"
            pipe.puts "x"
            expected << "What color text would you like executables with setguid bit sets to have?(use 'x' for default)\n"
            pipe.puts "cyan"
            expected << "What color text would you like directories writable to others, with sticky bit to have?(use 'x' for default)\n"
            pipe.puts "x"
            expected << "What color text would you like directories writable to others, without sticky bit to have?(use 'x' for default)\n"
            pipe.puts "light grey"
            expected << "New ls color profile created successfully!\n"
            pipe.close_write
            shell_output = pipe.read
        end
        assert_equal expected,shell_output
    end

end