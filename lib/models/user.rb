class User < ActiveRecord::Base
    has_many :games
    
    def validate_user? password
        self.password_string == password
    end

    def self.leaderboards
        binding.pry
    end

end