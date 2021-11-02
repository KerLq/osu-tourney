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

ActiveRecord::Schema.define(version: 2021_11_02_112312) do

  create_table "matches", force: :cascade do |t|
    t.string "mp_link"
    t.integer "warmup"
    t.decimal "matchcost"
    t.bigint "average_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tourney_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tourneys", force: :cascade do |t|
    t.string "title"
    t.string "spreadsheet"
    t.integer "match_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["match_id"], name: "index_tourneys_on_match_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "avatar_url"
    t.integer "user_id"
    t.integer "tourney_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.index ["tourney_id"], name: "index_users_on_tourney_id"
  end

  add_foreign_key "tourneys", "matches"
  add_foreign_key "users", "tourneys"
end
