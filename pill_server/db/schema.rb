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

ActiveRecord::Schema.define(version: 2019_11_02_181352) do

  create_table "histories", force: :cascade do |t|
    t.boolean "taken"
    t.integer "week_number"
  end

  create_table "pills", force: :cascade do |t|
    t.string "name"
    t.integer "count"
    t.boolean "active"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "day"
    t.integer "time"
    t.integer "pill_id"
    t.index ["pill_id"], name: "index_schedules_on_pill_id"
  end

end
