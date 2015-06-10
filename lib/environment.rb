require 'active_record'
Dir["./lib/*.rb"].each{|f| require f}
Dir["./app/**/*.rb"].each{|f| require f}

class Environment
    def self.current
        ENV["TEST"] ? "test" : "production"
    end
end

# connection_details = YAML::load(File.open('config/database.yml'))
# ActiveRecord::Base.establish_connection(connection_details[Environment.current])