User.destroy_all
Game.destroy_all

jack = User.create username: "Jack", password_string: "admin", hint: "because you're the boss around here"
reed = User.create username: "Reed", password_string: "admin", hint: "because you're the boss around here"
jon = User.create username: "Jon", password_string: "doomslayer", hint: "something about a dog"
kyle = User.create username: "Kyle", password_string: "password", hint: "not a very good password"

Game.create user_id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"
# Game.create id: jack.id, game_type: "game_type", result: "win"

