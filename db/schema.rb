# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_07_224236) do

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "hint"
  end

  create_table "war_games", force: :cascade do |t|
    t.integer "war_id"
    t.integer "user_id"
    t.index ["user_id"], name: "index_war_games_on_user_id"
    t.index ["war_id"], name: "index_war_games_on_war_id"
  end

  create_table "wars", force: :cascade do |t|
    t.string "result"
  end

end
