class User < ActiveRecord::Base
    has_many :games
    
    def validate_user? password
        self.password_string == password
    end

    def games_played
        Game.all.filter { |game| game.user_id == self.id }
    end

    def scores
        war_wins = games_played.filter { |game| game.result == "win" && game.game_type == "War" }.count
        war_losses = games_played.filter { |game| game.result == "loss" && game.game_type == "War" }.count
        blackJack_wins = games_played.filter { |game| game.result == "win" && game.game_type == "BlackJack" }.count
        blackJack_losses = games_played.filter { |game| game.result == "loss" && game.game_type == "BlackJack" }.count
        TTY::Table.new(["$$$", "War","BlackJack"], [["WINS", war_wins, blackJack_wins], ["LOSSES", war_losses, blackJack_losses]])
    end

end