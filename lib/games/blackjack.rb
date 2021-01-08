class BlackJack
    def prompt
        TTY::Prompt.new
    end

    def clear
        system "clear"
    end

    def welcome
        clear
        answer = prompt.yes? "Welcome! Would you like to play Black-Jack?"
        if answer == true
            new_game
        else
            exit 
        end
    end

    def card_deck
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    end

    def new_game
        @dealers_cards = []
        @my_cards = []
        2.times do |card|
            new_card = deal_card #deal_single_card twice and put it in your cards
            my_cards << new_card
            clear 
        end
        puts "Your cards: #{my_cards}" #look at cards
        2.times do |card|
            new_card = deal_card #deal_single_card twice and put it in dealers cards
            dealers_cards << new_card
        end
        puts "Dealers cards: #{dealers_cards}" #look at cards
        hit 
            
        
        result  
    
        #else complete_game
    end


    def hit
        prompt = TTY::Prompt.new
        answer = prompt.yes? "Would you like to hit?"
        if answer == true
            my_cards << 
            clear 
            puts "Your cards: #{my_cards}"
            puts "Dealers cards: #{dealers_cards}"
        end
    end
            
    def deal_card 
        card_deck.sample 
    end

    def result
        my_total = my_cards.reduce(0) do |sum, x|
            sum + x
        end
        puts my_total
    end

    def bust
        puts "Better luck next time!"
        exit
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



    #########WAR##########




    def deal
        @dealer_card = card_deck.sample
        @player_card = card_deck.sample
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













    # def start(your_answer)
    #     answer = "yes"
    #     puts "Welcome to BlackJack! Would you like to play?"
    #     if answer == your_answer
    #         deal_cards
    #     else
    #         exit
    # end

    # def deal_cards
    #     2.times
    #     possible_cards.random_select << your_cards
    #     2.times
    #     possible_cards.random_select << dealers_cards
    # end

    # def read_cards
    #     return your_cards
    #     return dealers_cards
    # end

    # def hit(your_answer)
    #     answer = "yes"
    #     puts "Would you like another card?"
    #     if answer == your_answer
    #         possible_cards.random_select << your_cards
    #     else
    #         compare
    #     end
    # end

    # #some function that give the dealer a card until he either beats you or busts
    # #compare actually just needs to show you your cards and the dealers cards
    # def compare(your_cards)
    #     if your_cards >> 21
    #         puts "Sorry, better luck next time"
    #     else
    #         puts "Congrats! You win! Would you like to play again?"
    #         if answer == "yes"
    #             deal_cards
    #         end
    #     end
    # end

    # def game_over
    #     exit_game
    # end
            
    def exit
        clear
        puts "Goodbye!"
    end
end

binding.pry
