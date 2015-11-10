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

ActiveRecord::Schema.define(version: 20151110193702) do

  create_table "buildings", force: :cascade do |t|
    t.integer  "building_number"
    t.string   "street_name",                      null: false
    t.string   "street_address_2"
    t.string   "street_address_3"
    t.string   "city",                             null: false
    t.string   "state"
    t.string   "postal_code"
    t.string   "country",                          null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "skip_validation",  default: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "buildings", ["city"], name: "index_buildings_on_city"
  add_index "buildings", ["country", "state", "city"], name: "index_buildings_on_country_and_state_and_city"
  add_index "buildings", ["country"], name: "index_buildings_on_country"
  add_index "buildings", ["state"], name: "index_buildings_on_state"
  add_index "buildings", ["street_name"], name: "index_buildings_on_street_name"

  create_table "reviews", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "subject_id"
    t.integer  "overall_rating"
    t.integer  "location_rating"
    t.integer  "value_rating"
    t.integer  "facilities_rating"
    t.integer  "cleanliness_rating"
    t.string   "headline"
    t.text     "details"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "from_month"
    t.integer  "to_month"
    t.integer  "from_year"
    t.integer  "to_year"
  end

  add_index "reviews", ["author_id"], name: "index_reviews_on_author_id"
  add_index "reviews", ["subject_id"], name: "index_reviews_on_subject_id"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "building_id"
    t.string   "postal_code"
    t.string   "city"
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "handle",                                 null: false
    t.boolean  "admin",                  default: false
    t.boolean  "renter",                 default: true
    t.boolean  "landlord",               default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
