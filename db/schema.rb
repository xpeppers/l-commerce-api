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

ActiveRecord::Schema.define(version: 20150929101906) do

  create_table "bought_offers", force: :cascade do |t|
    t.integer "order_id"
    t.integer "offer_id"
    t.string  "status",   default: "unused"
  end

  add_index "bought_offers", ["offer_id"], name: "index_bought_offers_on_offer_id"
  add_index "bought_offers", ["order_id"], name: "index_bought_offers_on_order_id"

  create_table "coupons", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coupons", ["order_id"], name: "index_coupons_on_order_id"

  create_table "offers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",          precision: 10, scale: 2
    t.string   "image_url"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "original_price", precision: 10, scale: 2
    t.string   "merchant"
    t.string   "telephone"
    t.string   "email"
    t.string   "web_site"
    t.string   "street"
    t.string   "zip_code"
    t.string   "city"
    t.string   "latitude"
    t.string   "longitude"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "paypal_payment_token"
    t.string   "status"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "provider_user_id"
    t.string   "token"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true

end
