# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_09_093211) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beat_boxers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.text "name"
    t.text "image"
    t.bigint "user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "winner"
    t.string "loser"
    t.integer "player_1_points"
    t.integer "player_2_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draw"
    t.string "player_1_comment"
    t.string "player_2_comment"
    t.string "player_1_user_name"
    t.string "player_2_user_name"
    t.integer "timer", default: 60
    t.integer "rounds", default: 0
  end

  create_table "matches_users", id: false, force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "user_id", null: false
    t.index ["match_id", "user_id"], name: "index_matches_users_on_match_id_and_user_id"
    t.index ["user_id", "match_id"], name: "index_matches_users_on_user_id_and_match_id"
  end

  create_table "user_stats", force: :cascade do |t|
    t.integer "wins"
    t.integer "lost"
    t.integer "skips"
    t.integer "games_played"
    t.integer "right_guesses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "draw", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.text "username"
    t.text "email"
    t.text "password"
    t.text "phone"

    t.unique_constraint ["email"], name: "uni_users_email"
  end

  add_foreign_key "images", "users", name: "fk_users_image"
end
