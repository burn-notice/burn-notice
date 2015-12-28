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

ActiveRecord::Schema.define(version: 20151227101153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "published_at"
    t.string   "tags",         limit: 255, default: [], array: true
    t.json     "content"
    t.json     "headline"
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta_users", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
    t.datetime "invited"
  end

  create_table "notices", force: :cascade do |t|
    t.json     "data"
    t.string   "token",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "question",   limit: 255
    t.integer  "status",                 default: 0
  end

  create_table "openings", force: :cascade do |t|
    t.string   "ip",            limit: 255
    t.text     "info"
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "meta"
    t.integer  "authorization",             default: 0
  end

  create_table "policies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.json     "setting"
    t.integer  "notice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                 limit: 255
    t.string   "nickname",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",                 limit: 255
    t.datetime "validation_date"
    t.integer  "access",                            default: 0
    t.string   "time_zone"
    t.string   "stripe_customer_token"
  end

end
