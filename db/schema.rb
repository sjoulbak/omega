# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160119190245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_users", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_users", ["course_id"], name: "index_course_users_on_course_id", using: :btree
  add_index "course_users", ["user_id"], name: "index_course_users_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.date     "begindatum"
    t.date     "einddatum"
    t.integer  "soortcourse_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "courses", ["soortcourse_id"], name: "index_courses_on_soortcourse_id", using: :btree

  create_table "soortcourses", force: :cascade do |t|
    t.string   "cursussoort"
    t.integer  "prijs"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "roepnaam"
    t.string   "tussenvoegsel"
    t.string   "achternaam"
    t.string   "adres"
    t.string   "woonplaats"
    t.string   "telefoon"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "admin",            default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
