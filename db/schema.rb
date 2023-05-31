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

ActiveRecord::Schema.define(version: 2023_05_31_062602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_stats", force: :cascade do |t|
    t.bigint "player_stat_id", null: false
    t.integer "points"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "match_date"
    t.bigint "user_id"
    t.index ["player_stat_id"], name: "index_match_stats_on_player_stat_id"
    t.index ["user_id"], name: "index_match_stats_on_user_id"
  end

  create_table "player_stats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_player_stats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin"
    t.string "nick_name"
    t.string "name"
    t.string "last_name"
    t.jsonb "interest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_stats", force: :cascade do |t|
    t.date "week_start_date"
    t.date "week_end_date"
    t.integer "total_points"
    t.integer "total_places"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_weekly_stats_on_user_id"
  end

  add_foreign_key "match_stats", "player_stats"
  add_foreign_key "match_stats", "users"
  add_foreign_key "player_stats", "users"
  add_foreign_key "weekly_stats", "users"
end
