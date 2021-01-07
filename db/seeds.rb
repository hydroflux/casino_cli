User.destroy_all
War.destroy_all
WarGame.destroy_all

jack = User.create username: "Jack", password_string: "admin", hint: "because you're the boss around here"
reed = User.create username: "Reed", password_string: "admin", hint: "because you're the boss around here"
jon = User.create username: "Jon", password_string: "doomslayer", hint: "something about a dog"
kyle = User.create username: "Kyle", password_string: "password", hint: "not a very good password"

win = War.create result: win
loss = War.create result: loss

WarGame.create user: jon, war: win
WarGame.create user: jack, war: loss
WarGame.create user: reed, war: win
WarGame.create user: kyle, war: win
WarGame.create user: jon, war: loss
WarGame.create user: jack, war: win
WarGame.create user: kyle, war: win
WarGame.create user: reed, war: loss
WarGame.create user: jack, war: win

