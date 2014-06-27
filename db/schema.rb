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

ActiveRecord::Schema.define(version: 20140627014113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "order_id"
    t.text     "content",    null: false
    t.integer  "rating",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["order_id"], name: "index_feedbacks_on_order_id", using: :btree

  create_table "items", force: true do |t|
    t.integer  "user_id"
    t.string   "brand",                              null: false
    t.string   "condition",                          null: false
    t.decimal  "original_price",                     null: false
    t.text     "description",                        null: false
    t.decimal  "sale_price"
    t.decimal  "trade_price"
    t.boolean  "allow_pickup",       default: false, null: false
    t.decimal  "weight",                             null: false
    t.string   "size",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                              null: false
    t.string   "category"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "hidden"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["item_id"], name: "index_likes_on_item_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "purchase_type", null: false
    t.datetime "shipping_date"
    t.string   "street",        null: false
    t.string   "city",          null: false
    t.string   "state",         null: false
    t.string   "zip",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping_type"
  end

  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "fname",               null: false
    t.string   "lname",               null: false
    t.string   "username",            null: false
    t.string   "email",               null: false
    t.string   "password_digest",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",               null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
