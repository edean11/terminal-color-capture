require 'Date'

class LSColorProfile

    ################
    ## Validation ##
    ################

    def self.validate_ls_input(answer)
        answer_key = ['x','none','black','red','green','brown','blue','magenta','cyan','lightgrey','bold']
        first_answer = answer_key.include?(answer.partition(/\s*[,\s]\s*/)[0])
        last_answers = (answer.partition(/\s*[,\s]\s*/)[2]).partition(/\s*[,\s]\s*/)
        second_answer = answer_key.include?(last_answers[0])
        third_answer = answer_key.include?(last_answers[2])
        answer_arr = [first_answer,second_answer,third_answer]
        !answer_arr.include?(false)
    end

    ####################
    ## Get Properties ##
    ####################

    def self.all
        Database.execute("SELECT * FROM ls_color_profiles").map do |row|
            color_scheme = LSColorProfile.new(row,true)
            color_scheme
        end
    end

    def self.count
        Database.execute("SELECT count(id) from ls_color_profiles")[0][0]
    end

    #######################
    ## Format Key String ##
    #######################

    def self.format_key_string(answer_arr)
        str = ""
        name = answer_arr[1]
        shifted = answer_arr.shift(2)
        answer_arr.each_slice(3) do |answer_triplet|
            color_key = {"black"=>"a","red"=>"b","green"=>"c","brown"=>"d","blue"=>"e",
                "magenta"=>"f","cyan"=>"g","lightgrey"=>"h","x"=>"x"}
            color = answer_triplet[0]
            format = answer_triplet[1]
            bg_color = answer_triplet[2]
            #text_color
            if color == 'x'
                str << color
            elsif format == 'bold'
                str << color_key[color].capitalize
            else
                str << color_key[color]
            end
            #background_color
            if bg_color == 'x'
                str << bg_color
            else
                str << color_key[bg_color]
            end
        end
        [name,str]
    end

    ###################
    ## Create Record ##
    ###################

    def self.create(answer_arr)
        arr = format_key_string(answer_arr)
        name = arr[0]
        key_string = arr[1]
        Database.execute("INSERT into ls_color_profiles "+
            "(name,key_string) VALUES (?,?)",[name,key_string])
    end

end