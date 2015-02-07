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

ActiveRecord::Schema.define(version: 20150207181809) do

  create_table "batches", force: true do |t|
    t.text "folder"
  end

  create_table "likes", force: true do |t|
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "likes"
  end

  create_table "outfits", force: true do |t|
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "outfits"
  end

  create_table "users", force: true do |t|
    t.string   "curate_user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preferences"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wardrobes", force: true do |t|
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "wardrobe"
  end

end
