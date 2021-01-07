class User < ActiveRecord::Base
    
    def validate_user? password
        self.password_string == password
    end

end