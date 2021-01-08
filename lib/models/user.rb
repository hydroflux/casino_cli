class User < ActiveRecord::Base
    has_many :games
    
    def validate_user? password
        self.password_string == password
    end

    def scores
        my_games = Game.all.filter { |game| game.user_id == self.id }
        war_wins = my_games.filter { |game| game.result == "win" && game.game_type == "War" }.count
        war_losses = my_games.filter { |game| game.result == "loss" && game.game_type == "War" }.count
        blackJack_wins = my_games.filter { |game| game.result == "win" && game.game_type == "BlackJack" }.count
        blackJack_losses = my_games.filter { |game| game.result == "loss" && game.game_type == "BlackJack" }.count
        TTY::Table.new(["War","BlackJack"], [[war_wins, blackJack_wins], [war_losses, blackJack_losses]])
    end

end