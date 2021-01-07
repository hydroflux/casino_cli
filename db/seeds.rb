User.destroy_all

User.create username: "Jack", password_string: "admin", hint: "because you're the boss around here"
User.create username: "Reed", password_string: "admin", hint: "because you're the boss around here"
User.create username: "Jon", password_string: "doomslayer", hint: "something about a dog"
User.create username: "Kyle", password_string: "password", hint: "not a very good password"