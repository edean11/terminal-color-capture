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
        it "should create a new record in the databse" do
            orig_count = LSColorProfile.count.to_i
            answer_arr = [nil,'test','blue','none','black','black','none','blue','green','bold','cyan']
            LSColorProfile.create(answer_arr)
            new_count = LSColorProfile.count.to_i
            assert_equal orig_count+1,new_count
        end
    end
end