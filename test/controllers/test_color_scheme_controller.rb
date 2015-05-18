require_relative '../helper'

describe ColorSchemeController do

    describe ".add" do
        before do
            color_scheme1 = ColorScheme.new.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
            color_scheme2 = ColorScheme.new.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
            ColorSchemeController.add(color_scheme1)
            ColorSchemeController.add(color_scheme2)
        end
        it "should return two records in the database" do
            assert_equal 2,ColorScheme.count
        end
    end
    describe ".index" do
        describe "if there are no color schemes in the databse" do
            # let(:controller){ColorSchemeController.new}
            it "should return an empty database message" do
                assert_equal "No color schemes found. Add a color scheme.\n",
                ColorSchemeController.index
            end
        end
        describe "if there are color schemes in the database" do
            before do
                color_scheme1 = ColorScheme.new.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
                color_scheme2 = ColorScheme.new.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
                color_scheme3 = ColorScheme.new.save([nil,'test3','red','bold','blue','10:00-11:00','false'],false)
                ColorSchemeController.add(color_scheme1)
                ColorSchemeController.add(color_scheme2)
                ColorSchemeController.add(color_scheme3)
            end
            it "should return the color schemes in database order, list format" do
                expected = "1. test\n2. test2\n3. test3\n"
                actual = ColorSchemeController.index
                assert_equal expected,actual
            end
        end
    end

    describe ".table" do
        describe "if there are no color schemes in the databse" do
            it "should return an empty database message" do
                assert_equal "No color schemes found. Add a color scheme.\n",
                    ColorSchemeController.table
            end
        end
        describe "if there are color schemes in the database" do
            before do
                color_scheme1 = ColorScheme.new.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
                color_scheme2 = ColorScheme.new.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
                ColorSchemeController.add(color_scheme1)
                ColorSchemeController.add(color_scheme2)
            end
            it "should return the color schemes in database order, table format" do
                expected = ""
                expected << "="*124+"\n"
                expected << "COLOR SCHEMES".center(124)+"\n"
                expected << "="*124+"\n"
                expected << "NAME".center(19)+"COLOR".center(19)+"FORMAT".center(19)+
                            "BG_COLOR".center(19)+"ACTIVE_CRITERIA".center(29)+"PROMPT".center(19)+"\n"
                expected << "-"*124+"\n"
                expected << "test".center(19)+"blue".center(19)+"none".center(19)+
                            "red".center(19)+"11:00-23:00".center(29)+"true".center(19)+"\n"
                expected << "-"*124+"\n"
                expected << "test2".center(19)+"black".center(19)+"none".center(19)+
                            "blue".center(19)+"10:00-11:00".center(29)+"false".center(19)+"\n"
                expected << "="*124+"\n"

                actual = ColorSchemeController.table
                assert_equal expected,actual
            end
        end
    end
end