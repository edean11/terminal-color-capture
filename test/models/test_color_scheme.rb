require_relative '../helper'

describe ColorScheme do
    describe "#all" do
        describe "if there are no color schemes in the databse" do
            it "should return an empty array" do
                assert_equal [],ColorScheme.all
            end
        end
        describe "if there are color schemes in the database" do
            before do
                setupDatabase()
                createColorScheme('test','blue','none','red')
                createColorScheme('test2','black','none','blue')
                createColorScheme('test3','green','none','blue')
            end
            it "should return an array" do
                assert_equal Array,ColorScheme.all.class
            end
            it "should return the color schemes in database order" do
                expected ['test','test2','test3']
                actual ColorScheme.all.map{|color_scheme| color_scheme.name}
                assert_equal expected,actual
            end
        end
    end

    describe "#count" do
        describe "if there are no color schemes in the databse" do
            it "should return 0" do
                assert_equal 0,ColorScheme.count
            end
        end
        describe "if there are color schemes in the database" do
            it "should return the correct count" do
                assert_equal 3,ColorScheme.count
            end
        end
    end

    # describe ".name gets populated from database" do
    #     it "gets populated from the database" do
    #     end
    # end
end

class TestColorScheme < Minitest::Test
end