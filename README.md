# Stay-At-Home Casino!


# General Information

Stay-At-Home Casino is a CLI application that allows a user to create a user profile, & then play a variety of Casino games, including BlackJack, War, & Strip Poker???
Stay-At-Home Casino tracks the user's "wins" & "losses", & user's are able to check this progress on a scoreboard.

# Introductory Video

(link)

# Technologies
- Ruby - Version 2.6.5
- ActiveRecord - Version 6.0
- Sinatra-ActiveRecord - Version 2.0
- SQLite3 - Version 1.4
- Require_All - Version 3.0
- TTY-Prompt - Version 0.23.0
- TTY-Box - Version 0.7.0
- TTY-Table - Version 0.12.0


# Setup
To run this project, install it locally by cloning the GitHub Repository down & running the following from the application folder:
``` ruby
bundle install
ruby runner.rb
```

# Code Examples

``` ruby
# Game Start
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
```

``` ruby
# Check Time User is Playing
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
```

``` ruby
# BlackJack
def new_game
    puts "Sounds good, I hope you're feeling lucky!"
    system `say "Sounds good, I hope you're feeling lucky!"`
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
```

``` ruby
# War
def new_game
    clear_terminal
    puts "Let's play! (Aces are low!)"
    system `say "Let's play! (Aces are low!)"`
    pause
    deal
    game_result
end
```


# Features
Completed:
- Create a user profile with a username, password, & password hint
- Logging in for returning users
- Choose from three (3) sample casino games for the user to play:
    - BlackJack
    - War
    - Strip Poker
- Check user scores for each game
- Ruby reads all prompts back to the User

To Do List
- Add additional games
- Increase general folksyness
- Update GUI, particularly for the scoreboard
- Update user prompt's overall sass
- Provide user with ability to compare their score against a "leaderboard"
- Provide user with ability to erase the scoreboard & high-tail it out of the casino

# Status
- Complete; Possible to include additional games & additional user functionality

# Contact
- Created by [Jack Hubert](https://github.com/hydroflux) & [Reed Roffis](https://github.com/reedroffis)
- Please contact us if you have any questions!