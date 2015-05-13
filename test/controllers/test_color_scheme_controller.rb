require_relative '../helper'

describe ColorSchemeController do

    describe ".add" do
        before do
            color_scheme1 = ColorScheme.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
            color_scheme2 = ColorScheme.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
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
                color_scheme1 = ColorScheme.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
                color_scheme2 = ColorScheme.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
                color_scheme3 = ColorScheme.save([nil,'test3','red','bold','blue','10:00-11:00','false'],false)
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
                color_scheme1 = ColorScheme.save([nil,'test','blue','none','red','11:00-23:00','true'],false)
                color_scheme2 = ColorScheme.save([nil,'test2','black','none','blue','10:00-11:00','false'],false)
                ColorSchemeController.add(color_scheme1)
                ColorSchemeController.add(color_scheme2)
            end
            it "should return the color schemes in database order, table format" do
                expected = ""
                expected << "="*105+"\n"
                expected << "COLOR SCHEMES".center(105)+"\n"
                expected << "="*105+"\n"
                expected << "NAME".center(15)+"COLOR".center(15)+"FORMAT".center(15)+
                            "BG_COLOR".center(15)+"ACTIVE".center(15)+"PROMPT".center(15)+"\n"
                expected << "-"*105+"\n"
                expected << "test".center(15)+"blue".center(15)+"none".center(15)+
                            "red".center(15)+"11:00-23:00".center(15)+"true".center(15)+"\n"
                expected << "-"*105+"\n"
                expected << "test2".center(15)+"black".center(15)+"none".center(15)+
                            "blue".center(15)+"10:00-11:00".center(15)+"false".center(15)+"\n"
                expected << "="*105+"\n"

                actual = ColorSchemeController.table
                assert_equal expected,actual
            end
        end
    end
end