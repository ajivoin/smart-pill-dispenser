# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_03_030257) do

  create_table "histories", force: :cascade do |t|
    t.integer "week"
    t.boolean "taken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schedule_id"
    t.index ["schedule_id"], name: "index_histories_on_schedule_id"
  end

  create_table "jonny_bois", force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pills", force: :cascade do |t|
    t.string "name"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "desc"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "time"
    t.integer "day0"
    t.integer "day1"
    t.integer "day2"
    t.integer "day3"
    t.integer "day4"
    t.integer "day5"
    t.integer "day6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pill_id"
    t.boolean "active"
    t.index ["pill_id"], name: "index_schedules_on_pill_id"
  end

end
