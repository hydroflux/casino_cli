class User < ActiveRecord::Base
    has_many :wars, through: :war_games
    
    def validate_user? password
        self.password_string == password
    end

end