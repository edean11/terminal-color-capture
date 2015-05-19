require_relative '../helper'

describe LSColorProfile do
    describe ".format_key_string" do
        it "should return an array with the name and key string" do
            answer_arr = [nil,'test','blue','none','black','black','none','blue','green','bold','cyan']
            formatted_arr = LSColorProfile.format_key_string(answer_arr)
            assert_equal ['test','eaaeCg'],formatted_arr
        end
    end
    describe ".create" do
        it "should create a new record in the database" do
            orig_count = LSColorProfile.count.to_i
            answer_arr = [nil,'test','blue','none','black','black','none','blue','green','bold','cyan']
            LSColorProfile.create(answer_arr)
            new_count = LSColorProfile.count.to_i
            assert_equal orig_count+1,new_count
        end
    end

    describe ".validate_existing_ls_color_profile_choice" do
        it "should return an array of all existing ls color scheme names" do
            ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
            LSColorProfileController.new.add(ls_color_profile1)
            arr = LSColorProfile.validate_existing_ls_color_profile_choice()
            assert_equal 'test',arr[0]
        end
    end

    describe ".validate_ls_color_profile_property_choice" do
        it "should return an array" do
            arr = LSColorProfile.validate_ls_color_profile_property_choice()
            assert_equal Array,arr.class
        end
        it "should return an array with all available properties" do
            arr = LSColorProfile.validate_ls_color_profile_property_choice()
            assert_equal true,(arr.include? 'directories')
        end
    end

    describe ".find_property_key_string_index" do
        it "should return an index number if property other than name is chosen" do
            ind = LSColorProfile.find_property_key_string_index('directories')
            assert_equal 0,ind
        end
        it "should return name if name is chosen" do
            str = LSColorProfile.find_property_key_string_index('name')
            assert_equal 'name',str
        end
    end

    describe ".delete" do
        before do
            ls_color_profile1 = [nil,'test','blue','none','black','red','none','blue','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
            LSColorProfileController.new.add(ls_color_profile1)
            ls_color_profile2 = [nil,'test2','blue','none','x','red','none','x','green','bold','black',
            'blue','bold','magenta','cyan','none','black','x','none','x','red','none','black',
            'blue','none','x','cyan','none','x','lightgrey','none','x','blue','none','black']
            LSColorProfileController.new.add(ls_color_profile2)
        end
        it "should return the a count one less than the number created" do
            id = LSColorProfile.get_id('test2')
            LSColorProfile.delete(id)
            assert_equal 1,LSColorProfile.count
        end
    end
end