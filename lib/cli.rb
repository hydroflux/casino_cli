class Cli
    ActiveRecord::Base.logger = nil

    def initialize
        @user = ''
        @weekday = ''
        @time_of_day = ''
    end

    def banner
        box = TTY::Box.frame(width: 80, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :white,
            bg: :blue,
            }) do
            "Stay-At-Home Casino"
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

    def welcome
        clear_terminal
        puts 'Hello, welcome to the "Stay-At-Home Casino"!'
        sleep 2
        clear_terminal
    end

    def play_prompt
        answer = prompt.yes? "Would you like to play a game with us today?"
        answer ? login_prompt : exit_casino
    end

    def login_prompt
        puts time_and_day
        sleep 1
        clear_terminal
        answer = prompt.yes? "Have you been here before?"
        answer ? login_user : new_user
    end

    def login_user
        clear_terminal
        username = prompt.ask "What's your name friend?"
        username.titleize
        # I'm not wearing my glasses this #{@time_of_day}?"
        clear_terminal
        @user = User.find_by username: username
        if @user
            puts "Hey there #{username}, I'm sorry I didn't recognize you at first!"
            sleep 1
            password = prompt.mask "Do you remember your secret passphrase?"
            if @user.validate_user? password
                puts "Oh I recognize you now. It's good to see you #{@user.username}!"
                game_prompt
            else
                clear_terminal
                puts "Sorry #{@user.username}, that doesn't line up with what we've got written down here."
                sleep 2
                hint = prompt.yes? "Do you need a hint?"
                if hint
                    clear_terminal
                    puts "Well I can't tell you outright, but it's #{@user.hint}..."
                    sleep 2
                else
                    clear_terminal
                    puts "That sounds like the #{@user.username} I know."
                    sleep 2
                end
                login_fail
            end
        else
            clear_terminal
            puts "Hmmm, I don't think I know a #{username}..."
            sleep 2
            login_fail
        end
    end

    def time_and_day
        now = Time.now
        @weekday = now.strftime("%A")
        hour = now.hour
        if hour < 12
            @time_of_day = "morning"
            "Look at you, gambling on a #{@weekday} #{@time_of_day}!"
        elsif hour < 16
            @time_of_day = "afternoon"
            "Thanks for coming by this #{@weekday} #{@time_of_day}!"
        else
            @time_of_day = "evening"
            "Wonderful, thank you for joining us this #{@weekday} #{@time_of_day}!"
        end
    end

    def login_fail
        continue = prompt.select "[What would you like to do?]" do |menu|
            menu.choice "Hang on, I remember now."
            menu.choice "I lied, I've never been here before."
            menu.choice "[Run]"
        end
        clear_terminal
        if continue == "Hang on, I remember now."
            puts "That's good to hear!"
            sleep 2
            login_user
        elsif continue == "I lied, I've never been here before."
            puts "Usually we don't take too kindly to that sort of thing around here, but I suppose I can let it slide this once."
            sleep 2
            new_user
        elsif continue == "[Run]"
            exit_casino
        end
    end

    def new_user
        clear_terminal
        puts "Well schucks, thanks for coming by!"
        sleep 1
        clear_terminal
        username = prompt.ask "What's your name, friend?"
        username.titleize
        password = prompt.mask "What would you like your secret passphrase to be, #{username}? So we know it's really you."
        hint = prompt.ask "What about a hint, in case you forget your password?"
        clear_terminal
        @user = User.create username: username, password_string: password, hint: hint
        answer = prompt.yes? "Hello there #{@user.username}! Are you ready to play a game?"
        answer ? game_prompt : exit_casino
    end

    def game_prompt
        clear_terminal
        game_choice = prompt.select "What would you like to play?" do |menu|
            menu.choice "Blackjack"
            menu.choice "War"
            menu.choice "Strip Poker"
            menu.choice "[Exit]"
        end
        if game_choice == "Blackjack"
            # Blackjack.new
            # play_game Blackjack
        elsif game_choice == "War"
            play_game War
        elsif game_choice == "Strip Poker"
            puts game_prompt_fail
        else
            exit_casino
        end
    end

    def game_prompt_fail
        clear_terminal
        puts "Now you know we don't do that sort of thing around here, stop messing around #{@user.username}"
        sleep 1
        puts "What do you really want to play?"
        sleep 1
        game_prompt
    end

    def play_game game
        new_game = game.new
        new_game.start
        if result != "quit"
            Game.create user_id: @user.id, game_type: "war", result: new_game.result
            play_again? game
        else
            game_prompt
        end
    end

    def play_again? game
        if prompt.yes? "Would you like to play another game?"
            play_game game
        else
            game_prompt
        end
    end 

    def exit_casino
        clear_terminal
        puts "We hate to see you go, but we love to watch you leave!"
        sleep 1
        puts "Thanks for coming, we'll see you again next time!"
        sleep 3
        clear_terminal
        # Roll credits
    end

end