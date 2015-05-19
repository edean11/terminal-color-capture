require 'highline/import'

class LSColorProfileController
    def index
        str = ""
        if LSColorProfile.count > 0
            ls_color_profiles = LSColorProfile.all
            ls_color_profiles.each_with_index do |ls_color_profile,index|
                str << "#{index+1}. #{ls_color_profile.name}\n"
            end
        else
            str << "No ls color profiles found. Add an ls color profile.\n"
        end
        str
    end

    def table
        columns = 2
        table_length = 60
        column_length = table_length/columns
        extra_length = 2
        str = ""
        if LSColorProfile.count > 0
            all_profiles = LSColorProfile.all
            str << "="*(table_length+extra_length)+"\n"
            str << "LS COLOR PROFILES".center(table_length+extra_length)+"\n"
            str << "="*(table_length+extra_length)+"\n"
            str << "NAME".center(column_length)+"KEY STRING".center(column_length)+"\n"
            str << "-"*(table_length+extra_length)+"\n"
            all_profiles.each_with_index do |ls_color_profile, index|
                str << ls_color_profile.name.center(column_length)+
                    ls_color_profile.key_string.center(column_length)+"\n"
                str << "-"*(table_length+extra_length)+"\n" if index != all_profiles.length-1
            end
            str << "="*(table_length+extra_length)+"\n"
        else
            str << "No ls color profiles found. Add an ls color profile.\n"
        end
        str
    end

    def add(answer_arr)
        LSColorProfile.create(answer_arr)
    end
end