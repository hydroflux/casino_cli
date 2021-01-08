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
- bundle install
- ruby runner.rb

# Code Examples

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


    

# Features
Completed:
- Create a user profile with a username, password, & password hint
- Logging in for returning users
- Choose from three (3) sample casino games for the user to play:
    - BlackJack
    - War
    - Strip Poker
- Check user scores for each game

To Do List
- Add additional games
- Increase overall folksyness
- Provide user with ability to compare their score against a "leaderboard"
- Provide user with ability to erase the scoreboard & high-tail it out of the casino

# Status
- Complete; Possible to include additional games & additional user functionality

# Contact
- Created by Jack Hubert (link) & Reed Roffis (link)
- Please contact us if you have any questions!


<!-- # Questions to Ask:
    # What do I want people to know about this project?
    # Who is going to be looking at this?

# Things to include:
    # Title
    # Project Description / What it Does / What it's For



    README Resources

Questions to ask:
What do I want people to know about this project?
Who is going to be looking at this?

Things to include:
Title
Project description/What it does/What it’s for
How to use the app
Technologies used
Notable features with Images/GIFs
Code snippets
How to collaborate
Future features and functionality
Challenges
Link to a demo video
Links to relevant repos (frontend/backend)
Contact
License

Using markdown:
GitHub Mastering Markdown
GitHub Docs
GitHub Markdown Cheatsheet
Another Markdown Cheatsheet

Making GIFs:
Giphy Capture
Mac Resources
Linux Resources
Windows Resources

Making Videos:
Mac Screen Record/Quicktime
Loom
OBS Studio
Zoom for groups

Examples:
TacoLandia
Left Overs


STAY-AT-HOME CASINO
- All of the gaming fun, with none of the leave-your-house risks

Table of Contents
- General Info
- Intro Video
- Technologies
- Setup
- Features
- Status
- Contact
<!-- - License -->
 -->