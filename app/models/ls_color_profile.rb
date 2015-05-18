require 'Date'

class LSColorProfile

    attr_accessor :record,:id,:name,:dir_color,:dir_format,:dir_bg_color,:sym_color,
                :sym_format,:sym_bg_color,:soc_color,:soc_format,:soc_bg_color,:pipe_color,:pipe_format,
                :pipe_bg_color,:exec_color,:exec_format,:exec_bg_color,:block_color,:block_format,
                :block_bg_color,:char_color,:char_format,:char_bg_color,:execuid_color,:execuid_format,
                :execuid_bg_color,:execgid_color,:execgid_format,:execgid_bg_color,:dir_sticky_color,
                :dir_sticky_format,:dir_sticky_bg_color,:dir_nosticky_color,:dir_nosticky_format,:dir_nosticky_bg_color

    def initialize(record,has_id)
        if has_id
            self.id = record[0]
            self.active = record[32]
            self.created_at = record[33]
        end
        self.name = record[1]
        self.dir_color = record[2]
        self.dir_format = record[3]
        self.dir_bg_color = record[4]
        self.sym_color = record[5]
        self.sym_format = record[6]
        self.sym_bg_color = record[7]
        self.soc_color = record[8]
        self.soc_format = record[9]
        self.soc_bg_color = record[10]
        self.pipe_color = record[11]
        self.pipe_format = record[12]
        self.pipe_bg_color = record[13]
        self.exec_color = record[14]
        self.exec_format = record[15]
        self.exec_bg_color = record[16]
        self.block_color = record[17]
        self.block_format = record[18]
        self.block_bg_color = record[19]
        self.char_color = record[20]
        self.char_format = record[21]
        self.char_bg_color = record[22]
        self.execuid_color = record[20]
        self.execuid_format = record[21]
        self.execuid_bg_color = record[22]
        self.execgid_color = record[23]
        self.execgid_format = record[24]
        self.execgid_bg_color = record[25]
        self.dir_sticky_color = record[26]
        self.dir_sticky_format = record[27]
        self.dir_sticky_bg_color = record[28]
        self.dir_nosticky_color = record[29]
        self.dir_nosticky_format = record[30]
        self.dir_nosticky_bg_color = record[31]
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


    def self.create(name,dir_color,dir_format,dir_bg_color,sym_color,sym_format,sym_bg_color,
            soc_color,soc_format,soc_bg_color,pipe_color,pipe_format,pipe_bg_color,
            exec_color,exec_format,exec_bg_color,block_color,block_format,block_bg_color,
            char_color,char_format,char_bg_color,execuid_color,execuid_format,execuid_bg_color,
            execgid_color,execgid_format,execgid_bg_color,dir_sticky_color,dir_sticky_format,
            dir_sticky_bg_color,dir_nosticky_color,dir_nosticky_format,dir_nosticky_bg_color)
        Database.execute("INSERT into ls_color_profiles "+
            "(name,dir_color,dir_format,dir_bg_color,sym_color,sym_format,sym_bg_color,"+
            "soc_color,soc_format,soc_bg_color,pipe_color,pipe_format,pipe_bg_color,"+
            "exec_color,exec_format,exec_bg_color,block_color,block_format,block_bg_color,"+
            "char_color,char_format,char_bg_color,execuid_color,execuid_format,execuid_bg_color,"+
            "execgid_color,execgid_format,execgid_bg_color,dir_sticky_color,dir_sticky_format,"+
            "dir_sticky_bg_color,dir_nosticky_color,dir_nosticky_format,dir_nosticky_bg_color)"+
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            [name,dir_color,dir_format,dir_bg_color,sym_color,sym_format,sym_bg_color,
            soc_color,soc_format,soc_bg_color,pipe_color,pipe_format,pipe_bg_color,
            exec_color,exec_format,exec_bg_color,block_color,block_format,block_bg_color,
            char_color,char_format,char_bg_color,execuid_color,execuid_format,execuid_bg_color,
            execgid_color,execgid_format,execgid_bg_color,dir_sticky_color,dir_sticky_format,
            dir_sticky_bg_color,dir_nosticky_color,dir_nosticky_format,dir_nosticky_bg_color])
    end

end