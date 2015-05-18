require_relative '../helper'

describe ColorScheme do
    describe ".create_or_backup" do
        it "should ensure a backup file is created" do
            BashFile.create_or_backup
            assert_equal true,File.exist?(ENV['HOME'] + '/.bash_profile_bak')
        end
    end

    describe ".prepare" do
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        before do
            BashFile.prepare
        end
        it "should have an original PS1" do
            assert_equal true,(bash_file.include? "original_export PS1")
        end
        it "should have a COLOR alias" do
            assert_equal true,(bash_file.include? "alias COLOR")
        end
    end
end