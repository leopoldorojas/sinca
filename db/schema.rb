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

ActiveRecord::Schema.define(version: 20141119181126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credit_companies", force: true do |t|
    t.string   "name"
    t.string   "identifier"
    t.string   "contact"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  add_index "credit_companies", ["location_id"], name: "index_credit_companies_on_location_id", using: :btree

  create_table "indicators", force: true do |t|
    t.datetime "register_date"
    t.integer  "credit_company_id"
    t.string   "file_name"
    t.decimal  "indicator_1"
    t.decimal  "indicator_2"
    t.decimal  "indicator_3"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "indicator_4"
    t.decimal  "indicator_5"
    t.decimal  "indicator_6"
    t.decimal  "indicator_7"
  end

  create_table "locations", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "approved",               default: false, null: false
    t.integer  "credit_company_id"
    t.string   "role"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["credit_company_id"], name: "index_users_on_credit_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
