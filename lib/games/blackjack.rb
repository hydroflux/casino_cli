class Blackjack
    attr_reader :result, :game_type

    def banner
        box = TTY::Box.frame(width: 120, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :black,
            bg: :white,
            }) do
            "Stay-At-Home Casino: BlackJack Edition"
        end
        print box
        puts "\n"
    end

    def prompt
        TTY::Prompt.new
    end

    def clear
        system "clear"
        banner
    end
    
    def pause
        puts "Press [ENTER] to continue."
        gets.chomp
    end

    def welcome
        system `say "Welcome to Stay-At-Home Casino: BlackJack Edition"`
    end

    def start replay=nil
        @game_type = "BlackJack"
        clear
        if replay == nil
            welcome
        end
        system `say "Are you ready to play BlackJack?"`
        answer = prompt.yes? "Are you ready to play BlackJack?"
        clear
        if answer == true
            new_game
        else
            @result = "quit" 
        end
    end

    def card_deck
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
    end

    def deal_card 
        card_deck.sample 
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

    def new_game
        puts "Sounds good, I hope you're feeling lucky! (Aces are low)"
        system `say "Sounds good, I hope you're feeling lucky! (Aces are low)"`
        @dealer_cards = []
        @my_cards = []
        open
        while card_total(@my_cards) < 21 && hit?
            clear
            @my_cards << deal_card
            read_my_cards
        end
        end_game
    end

    def open
        2.times { |card| @my_cards << deal_card }
        2.times { |card| @dealer_cards << deal_card }
        read_my_cards
    end
    
    def read_my_cards
        clear
        puts "MY CARDS:"
        @my_cards.map do |card|
            puts read_card card
        end
        sleep 2
    end

    def read_all_cards
        clear
        puts "MY CARDS:"
        @my_cards.map do |card|
            puts read_card card
        end
        puts " "
        puts "DEALER CARDS:"
        @dealer_cards.map do |card|
            puts read_card card
        end
        sleep 1
    end

    def hit?
        puts " "
        system `say "Would you like to hit?"`
        prompt.yes? "Would you like to hit?"
    end

    def card_total hand
        hand.reduce do |sum, card|
            sum + card
        end
    end

    def end_game
        clear
        my_total = card_total @my_cards
        dealer_total = card_total @dealer_cards
        read_all_cards
        if my_total > 21
            puts "Oops! You busted. Better luck next time!"
            system `say "Oops! You busted. Better luck next time!"`
            sleep 1
            @result = "lose"
        elsif my_total == 21
            puts "Holy shit! You hit 21! You win!"
            system `say "Holy shit! You hit 21! You win!"`
            sleep 1
            @result = "win"
        elsif my_total > dealer_total
            puts "Looks like you're winning, time for me to hit."
            system `say "Looks like you're winning, time for me to hit."`
            sleep 1
            while dealer_total < my_total && dealer_total < 21 do
                @dealer_cards << deal_card
                read_all_cards
                sleep 2
                dealer_total = card_total @dealer_cards
                if dealer_total > 21
                    clear
                    puts "Oops, looks like I busted this time. Congratulations, you win!"
                    system `say "Oops, looks like I busted this time. Congratulations, you win!"`
                    sleep 1
                    @result = "win"
                elsif dealer_total == 21
                    clear
                    puts "Holy shit! I can't believe I hit 21! You lose sucker."
                    system `say "Holy shit! I can't believe I hit 21! You lose sucker."`
                    sleep 1
                    @result = "win"
                elsif dealer_total > my_total
                    clear
                    puts "Looks like I win this one!"
                    system `say "Looks like I win this one!"`
                    sleep 1
                    @result = "lose"
                end
            end
        elsif my_total == dealer_total
            clear
            read_all_cards
            puts "We were tied, I'm counting that as a loss for you."
            system `say "We were tied, I'm counting that as a loss for you."`
            sleep 1
            @result = "loss"
        end
        pause
    end

end