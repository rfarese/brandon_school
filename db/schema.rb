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

ActiveRecord::Schema.define(version: 20170113205536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beds", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "beds", ["room_id"], name: "index_beds_on_room_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["house_id"], name: "index_permissions_on_house_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "qrcodes", force: :cascade do |t|
    t.string   "image"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "qrcodes", ["room_id"], name: "index_qrcodes_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rooms", ["house_id"], name: "index_rooms_on_house_id", using: :btree

  create_table "student_checks", force: :cascade do |t|
    t.string   "status",     null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "initials",   limit: 3, null: false
    t.integer  "bed_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "students", ["bed_id"], name: "index_students_on_bed_id", using: :btree

  create_table "tours", force: :cascade do |t|
    t.string   "status",     null: false
    t.string   "selfie",     null: false
    t.integer  "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tours", ["house_id"], name: "index_tours_on_house_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                null: false
    t.string   "encrypted_password",     default: "",                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name",                                               null: false
    t.string   "role",                   default: "overnight_staff", null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "qrcodes", "rooms"
  add_foreign_key "student_checks", "students"
end
