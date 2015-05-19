require 'Date'

class LSColorProfile

    attr_accessor :id,:name,:active,:created_at,:key_string,:accepted_props

    def initialize(record,has_id)
        if has_id
            self.id = record[0]
            self.active = record[3]
            self.created_at = record[4]
        end
        self.name = record[1]
        self.key_string = record[2]
    end

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

    def self.get_id(name)
        Database.execute("SELECT id FROM ls_color_profiles WHERE name = '"+name+"'")[0][0]
    end

    def self.get_props(name)
        id = get_id(name).to_s
        Database.execute("SELECT * FROM ls_color_profiles WHERE id = '"+id+"'").map do |row|
            ls_color_profile = LSColorProfile.new(row,true)
            ls_color_profile
        end
    end

    #######################
    ## Format Key String ##
    #######################

    def self.find_color_keys(answer_triplet)
        str = ""
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
        str
    end

    def self.format_key_string(answer_arr)
        str = ""
        name = answer_arr[1]
        shifted = answer_arr.shift(2)
        answer_arr.each_slice(3) do |answer_triplet|
            str << find_color_keys(answer_triplet)
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

    #####################
    ## Activate Record ##
    #####################

    def self.activate(key_string)
        bash_path = ENV['HOME'] + '/.bash_profile'
        bash_file = File.read(bash_path)
        #replace LSCOLORS export with new export
        new_bash_file = bash_file.gsub(/^export LSCOLORS\s*=\s*[a-hA-HxX]*/,"export LSCOLORS="+key_string)
        File.open(bash_path, "w"){|file| file.puts new_bash_file }
    end

    #################
    ## Edit Record ##
    #################

    def self.validate_existing_ls_color_profile_choice
        all_profiles = LSColorProfile.all()
        accepted_responses = []
        all_profiles.each do |ls_profile|
            accepted_responses << ls_profile.name
        end
        accepted_responses
    end

    def self.validate_ls_color_profile_property_choice
        arr = []
        accepted_props = ['name','directories','symbolic links','sockets','pipes','executables','block specials',
            'character specials','executables with setuid bit sets','executables with setgid bit sets',
            'directories writable to others, with sticky bit','directories writable to others, without sticky bit']
        accepted_props.each do |prop|
            arr << prop
            arr << prop.upcase
            arr << prop.capitalize
        end
        arr
    end

    def self.find_property_key_string_index(property)
        ind = ""
        accepted = ['directories','symbolic links','sockets','pipes','executables','block specials',
            'character specials','executables with setuid bit sets','executables with setgid bit sets',
            'directories writable to others, with sticky bit','directories writable to others, without sticky bit']
        prop = property.downcase
        case prop
        when 'name'
            ind = 'name'
        else
            ind = (2*accepted.index(prop))+(accepted.index(prop))
        end
        ind
    end

    def self.update_name(id,val)
        stmt = "UPDATE ls_color_profiles SET name ='"+val+"' WHERE id = '"+id.to_s+"'"
        Database.execute(stmt)
    end

    def self.update_key_string(id,start_ind,new_key)
        key_string = Database.execute("SELECT key_string FROM ls_color_profiles WHERE id = '"+id.to_s+"'")[0][0]
        puts key_string
        key_string[start_ind,start_ind+2] = new_key
        stmt = "UPDATE ls_color_profiles SET key_string='"+key_string+"' WHERE id = '"+id.to_s+"'"
        Database.execute(stmt)
    end

    ###################
    ## Delete Record ##
    ###################

    def self.delete(id)
        Database.execute("DELETE FROM ls_color_profiles WHERE id = '"+id.to_s+"'")
    end

end