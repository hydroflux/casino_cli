class War
    attr_reader :result, :game_type

    def banner
        box = TTY::Box.frame(width: 120, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :white,
            bg: :red,
            }) do
            "Stay-At-Home Casino: War Edition"
        end
        print box
        puts "\n"
    end

    def start replay=nil
        clear_terminal
        if replay == nil
            welcome
        end
        play_prompt
    end

    def clear_terminal
        system 'clear'
        banner
    end

    def prompt
        TTY::Prompt.new
    end

    def pause
        puts "Press [ENTER] to continue."
        gets.chomp
    end
    
    def welcome
        @game_type = "War"
        puts "Welcome to Stay-At-Home War!"
        system `say "Welcome to Stay-At-Home War!"`
        clear_terminal
    end

    def play_prompt
        system `say "Are you ready to play a game of War?"`
        answer = prompt.yes? "Are you ready to play a game of War?"
        answer ? new_game : "quit"
    end

    def card_deck
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    end

    def new_game
        clear_terminal
        puts "Let's play! (Aces are low!)"
        system `say "Let's play! (Aces are low!)"`
        pause
        deal
        game_result
    end

    def deal
        @dealer_card = card_deck.sample
        @player_card = card_deck.sample
    end

    def read_card card
        if card == 1
            "Ace"
        elsif card == 11
            "Jack"
        elsif card == 12
            "Queen"
        elsif card == 13
            "King"
        else
            card.to_s
        end
    end

    def game_result
        if @dealer_card > @player_card
            puts "You got a #{read_card @player_card}, but I got a #{read_card @dealer_card}! I win!"
            system `say "You got a #{read_card @player_card}, but I got a #{read_card @dealer_card}! I win!"`
            @result = "loss"
        elsif @dealer_card < @player_card
            puts "I only got a #{read_card @dealer_card}, but you got a #{read_card @player_card}. You win, great work!"
            system `say "I only got a #{read_card @dealer_card}, but you got a #{read_card @player_card}. You win, great work!"`
            @result = "win"
        else
            puts "We both got a #{read_card @dealer_card}. That's a tie!"
            system `say "We both got a #{read_card @dealer_card}. That's a tie!"`
            puts "Time to go to war!"
            system `say "Time to go to war!"`
            war
        end
        pause
    end

    def war
        deal
        game_result
    end

end