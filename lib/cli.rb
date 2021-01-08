class Cli
    ActiveRecord::Base.logger = nil

    def initialize
        @user = ''
        @weekday = ''
        @time_of_day = ''
    end

    def banner
        box = TTY::Box.frame(width: 100, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :white,
            bg: :blue,
            }) do
            "Stay-At-Home Casino"
        end
        print box
        puts "\n"
    end

    def scoreboard_banner
        box = TTY::Box.frame(width: 100, height: 5, border: :thick, align: :center, padding: 1, style: {
            fg: :black,
            bg: :yellow,
            }) do
            "#{@user.username}'s Scores"
        end
        print box
        puts "\n"
    end

    def pause
        puts "Press [ENTER] to continue."
        gets.chomp
    end

    def start
        welcome
        play_prompt
    end

    def clear_terminal alt=nil
        system 'clear'
        if alt == nil
            banner
        else
            scoreboard_banner
        end
    end

    def prompt
        TTY::Prompt.new
    end

    def welcome
        clear_terminal
        puts 'Hello, welcome to the "Stay-At-Home Casino"!'
        system `say "Welcome to the Stay At Home Casino App!"`
        sleep 1
        clear_terminal
    end

    def play_prompt
        system `say "Would you like to play a game with us today?"`
        answer = prompt.yes? "Would you like to play a game with us today?"
        answer ? login_prompt : exit_casino
    end

    def login_prompt
        puts time_and_day
        system `say #{time_and_day}`
        sleep 1
        clear_terminal
        system `say "Have you been here before?"`
        answer = prompt.yes? "Have you been here before?"
        answer ? login_user : new_user
    end

    def login_user
        clear_terminal
        system `say "What's your name friend?"`
        username = prompt.ask "What's your name friend?"
        username.titleize
        clear_terminal
        @user = User.find_by username: username
        if @user
            puts "Hey there #{username}, I'm sorry I didn't recognize you at first!"
            system `say "Hey there #{username}, I'm sorry I didn't recognize you at first!"`
            system `say "Do you remember your secret passphrase?"`
            password = prompt.mask "Do you remember your secret passphrase?"
            if @user.validate_user? password
                puts "Oh I recognize you now. It's good to see you #{@user.username}!"
                system `say "Oh I recognize you now. It's good to see you #{@user.username}!"`
                game_prompt
            else
                clear_terminal
                puts "Sorry #{@user.username}, that doesn't line up with what we've got written down here."
                system `say "Sorry #{@user.username}, that doesn't line up with what we've got written down here."`
                system `say "Do you need a hint?"`
                hint = prompt.yes? "Do you need a hint?"
                if hint
                    clear_terminal
                    puts "Well I can't tell you outright, but it's #{@user.hint}..."
                    system `say "Well I can't tell you outright, but it's #{@user.hint}..."`
                else
                    clear_terminal
                    puts "That sounds like the #{@user.username} I know."
                    system `say "That sounds like the #{@user.username} I know."`
                end
                login_fail
            end
        else
            clear_terminal
            puts "Hmmm, I don't think I know a #{username}..."
            system `say "Hmmm, I don't think I know a #{username}..."`
            login_fail
        end
    end

    def time_and_day
        now = Time.now
        @weekday = now.strftime("%A")
        hour = now.hour
        if hour < 13
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
        clear_terminal
        continue = prompt.select "[What would you like to do?]" do |menu|
            menu.choice "Hang on, I remember now."
            menu.choice "I lied, I've never been here before."
            menu.choice "[Run]"
        end
        clear_terminal
        if continue == "Hang on, I remember now."
            puts "That's good to hear!"
            system `say "That's good to hear!"`
            login_user
        elsif continue == "I lied, I've never been here before."
            puts "Usually we don't take too kindly to that sort of thing around here, but I suppose I can let it slide this once."
            system `say "Usually we don't take too kindly to that sort of thing around here, but I suppose I can let it slide this once."`
            sleep 2
            new_user
        elsif continue == "[Run]"
            exit_casino
        end
    end

    def new_user
        clear_terminal
        puts "Well schucks, thanks for coming to our casino!"
        system `say "Well schucks, thanks for coming to our casino!"`
        sleep 1
        clear_terminal
        system `say "What's your name, friend?"`
        username = prompt.ask "What's your name, friend?"
        username.titleize
        system `say "What would you like your secret passphrase to be, #{username}?"`
        password = prompt.mask "What would you like your secret passphrase to be, #{username}?"
        system `say "What about a hint, in case you forget your password?"`
        hint = prompt.ask "What about a hint, in case you forget your password?"
        clear_terminal
        @user = User.create username: username, password_string: password, hint: hint
        system `say "Hello there #{@user.username}! Are you ready to play a game?"`
        answer = prompt.yes? "Hello there #{@user.username}! Are you ready to play a game?"
        answer ? game_prompt : exit_casino
    end

    def game_prompt
        clear_terminal
        system `say "What would you like to play?"`
        game_choice = prompt.select "What would you like to play?" do |menu|
            menu.choice "Blackjack"
            menu.choice "War"
            menu.choice "Strip Poker"
            if @user.games_played.count > 0
                menu.choice "[Check Your Score]"
            end
            menu.choice "[Exit]"
        end
        if game_choice == "Blackjack"
            play_game Blackjack
        elsif game_choice == "War"
            play_game War
        elsif game_choice == "Strip Poker"
            puts game_prompt_fail
        elsif game_choice == "[Check Your Score]"
            check_score
        else
            exit_casino
        end
    end

    def game_prompt_fail
        clear_terminal
        puts "Now you know we don't do that sort of thing around here, stop messing around #{@user.username}."
        system `say "Now you know we don't do that sort of thing around here, stop messing around #{@user.username}."`
        sleep 1
        game_prompt
    end

    def play_game game
        new_game = game.new
        new_game.start
        if new_game.result != "quit"
            Game.create user_id: @user.id, game_type: new_game.game_type, result: new_game.result
            play_again? game
        else
            game_prompt
        end
    end

    def play_again? game
        system `say "Would you like to play another round?"`
        if prompt.yes? "Would you like to play another round?"
            play_game game
        else
            game_prompt
        end
    end 

    def check_score
        clear_terminal "alt"
        system `say "#{@user.username}'s Stay-At-Home Casino Scores"`
        puts @user.scores.render(:ascii)
        pause
        game_prompt
    end

    def exit_casino
        clear_terminal
        puts "We hate to see you go, but we love to watch you leave!"
        system `say "We hate to see you go, but we love to watch you leave!"`
        puts "Thanks for coming, we'll see you again next time!"
        system `say "Thanks for coming, we'll see you again next time!"`
        sleep 3
        clear_terminal
        # Roll credits
    end

end