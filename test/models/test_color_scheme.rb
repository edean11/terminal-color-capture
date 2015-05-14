require_relative '../helper'

describe ColorScheme do
    describe ".create & .all" do
        describe "if there are no color schemes in the databse" do
            it "should return an empty array" do
                assert_equal [],ColorScheme.all
            end
        end
        describe "if there are color schemes in the database" do
            before do
                ColorScheme.create('test','blue','none','red','11:00-23:00','true')
                ColorScheme.create('test2','black','none','blue','10:00-11:00','false')
                ColorScheme.create('test3','green','none','blue','9:00-10:00','true')
            end
            it "should return an array" do
                assert_equal Array,ColorScheme.all.class
            end
            it "should return the color schemes in database order" do
                expected = ['test','test2','test3']
                actual = ColorScheme.all.map{|color_scheme| color_scheme.name}
                assert_equal expected,actual
            end
        end
    end

    describe ".create & .count" do
        describe "if there are no color schemes in the databse" do
            it "should return 0" do
                assert_equal 0,ColorScheme.count
            end
        end
        describe "if there are color schemes in the database" do
            before do
                ColorScheme.create('test','blue','none','red','11:00-23:00','true')
                ColorScheme.create('test2','black','none','blue','10:00-11:00','false')
                ColorScheme.create('test3','green','none','blue','9:00-10:00','true')
            end
            it "should return the correct count" do
                assert_equal 3,ColorScheme.count
            end
            it "should contain default value" do
                expected=[['false'],['false'],['false']]
                actual=Database.execute("SELECT active FROM color_schemes")
                assert_equal expected,actual
            end
        end
    end

    describe ".get_id" do
        before do
            ColorScheme.create('test','blue','none','red','11:00-23:00','true')
            ColorScheme.create('test2','black','none','blue','10:00-11:00','false')
            ColorScheme.create('test3','green','none','blue','9:00-10:00','true')
        end
        it "should return an integer that corresponds to the id of the name given" do
            cs = ColorScheme.get_id('test2')
            assert cs.to_i > 0
        end
    end

    describe ".delete" do
        before do
            ColorScheme.create('test','blue','none','red','11:00-23:00','true')
            ColorScheme.create('test2','black','none','blue','10:00-11:00','false')
            ColorScheme.create('test3','green','none','blue','9:00-10:00','true')
        end
        it "should return the a count one less than the number created" do
            id = ColorScheme.get_id('test2')
            ColorScheme.delete(id)
            assert_equal 2,ColorScheme.count
        end
    end

    describe ".update" do
        before do
            ColorScheme.create('test','blue','none','red','11:00-23:00','true')
            ColorScheme.create('test2','black','none','blue','10:00-11:00','false')
            ColorScheme.create('test3','green','none','blue','9:00-10:00','true')
        end
        it "should return an array with an updated name value" do
            test2_id = ColorScheme.get_id('test2')
            color_scheme1 = ColorScheme.save([test2_id,'changed','black','none','blue','10:00-11:00','false'],true)
            ColorScheme.update(color_scheme1)
            expected = ['test','changed','test3']
            actual = ColorScheme.all.map{|color_scheme| color_scheme.name}
            assert_equal expected,actual
        end
    end
end