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

ActiveRecord::Schema.define(version: 20140624194014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: true do |t|
    t.integer  "user_id"
    t.string   "brand",                          null: false
    t.string   "condition",                      null: false
    t.decimal  "original_price",                 null: false
    t.text     "description",                    null: false
    t.decimal  "sale_price",                     null: false
    t.integer  "trade_price",                    null: false
    t.boolean  "allow_pickup",   default: false, null: false
    t.decimal  "weight",                         null: false
    t.string   "size",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                          null: false
    t.string   "category"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "fname",           null: false
    t.string   "lname",           null: false
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",           null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
