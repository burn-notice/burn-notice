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

ActiveRecord::Schema.define(version: 20141222164002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "published_at"
    t.string   "tags",         default: [], array: true
    t.json     "content"
    t.json     "headline"
  end

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta_users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "invited"
  end

  create_table "google_auth_connections", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "status",       default: 0
    t.string   "token"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", force: true do |t|
    t.json     "data"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question"
    t.integer  "status",                    default: 0
    t.integer  "google_auth_connection_id"
  end

  add_index "notices", ["google_auth_connection_id"], name: "index_notices_on_google_auth_connection_id", using: :btree

  create_table "openings", force: true do |t|
    t.string   "ip"
    t.text     "info"
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "meta"
    t.integer  "authorization", default: 0
  end

  create_table "policies", force: true do |t|
    t.string   "name"
    t.json     "setting"
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.datetime "validation_date"
  end

end
