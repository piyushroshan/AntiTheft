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

ActiveRecord::Schema.define(version: 20140413070052) do

  create_table "devices", force: true do |t|
    t.string   "macaddress"
    t.string   "nickname"
    t.text     "description"
    t.integer  "user_id"
    t.boolean  "stolen"
    t.string   "secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["macaddress"], name: "index_devices_on_macaddress"

  create_table "logs", force: true do |t|
    t.string   "ip_address"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "log_file"
  end

  add_index "logs", ["device_id"], name: "index_logs_on_device_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",  default: "",    null: false
    t.integer  "roles_mask"
    t.boolean  "active",            default: false, null: false
  end

  add_index "users", ["perishable_token"], name: "index_users_on_perishable_token"

end
