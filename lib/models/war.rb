class War

    def initialize
        @result = 'quit'
    end

    def banner
        box = TTY::Box.frame(width: 80, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :white,
            bg: :red,
            }) do
            "Stay-At-Home War"
        end
        print box
        puts "\n"
    end

    def start
        welcome
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
        clear_terminal
        puts "Welcome to Stay-At-Home War!"
        sleep(2)
        clear_terminal
    end

    def play_prompt
        answer = prompt.yes? "Are you ready to play a game of War?"
        answer ? new_game : "quit"
    end

    def card_deck
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    end

    def new_game
        clear_terminal
        puts "Let's play! Are you ready? (Aces are low!)"
        pause
        deal
        @result = game_result
    end

    def deal
        @dealer_card = card_deck.sample
        @player_card = card_deck.sample
    end

    def read_card card
        if card == 1
            "A"
        elsif card == 11
            "J"
        elsif card == 12
            "Q"
        elsif card == 13
            "K"
        else
            card.to_s
        end
    end

    def game_result
        if @dealer_card > @player_card
            puts "You got #{read_card @player_card}, but I got #{read_card @dealer_card}! I win! "
            "loss"
        elsif @dealer_card < @player_card
            puts "I only got #{read_card @dealer_card}, but you got #{read_card @player_card}. You win, great work!"
            "win"
        else
            puts "We both got #{read_card @dealer_card}. That's a tie!"
            puts "Time to go to war!"
            sleep 1
            war
        end
        pause
    end

    def war
        deal
        game_result
    end

end