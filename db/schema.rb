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

ActiveRecord::Schema.define(version: 20170130091844) do

  create_table "comment_houses", force: :cascade do |t|
    t.integer  "review_house_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "comment_lives", force: :cascade do |t|
    t.integer  "review_life_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hash_tag_refs", force: :cascade do |t|
    t.integer  "hash_tag_id"
    t.integer  "review_life_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hash_tags", force: :cascade do |t|
    t.string   "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pic_houses", force: :cascade do |t|
    t.integer  "review_house_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "pros_and_cons", force: :cascade do |t|
    t.integer  "review_house_id"
    t.integer  "content_type"
    t.string   "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "review_houses", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "title",                  null: false
    t.string   "address",                null: false
    t.datetime "start_time",             null: false
    t.datetime "end_time",               null: false
    t.integer  "price_satisfaction",     null: false
    t.integer  "residence_satisfaction", null: false
    t.integer  "env_satisfaction",       null: false
    t.text     "price_review",           null: false
    t.text     "residence_review",       null: false
    t.text     "env_review",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "review_lives", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "scrap_houses", force: :cascade do |t|
    t.integer  "review_house_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "scrap_lives", force: :cascade do |t|
    t.integer  "review_life_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "subcomment_houses", force: :cascade do |t|
    t.integer  "comment_house_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "subcomment_lives", force: :cascade do |t|
    t.integer  "comment_life_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "upvote_comment_houses", force: :cascade do |t|
    t.integer  "comment_house_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "upvote_comment_lives", force: :cascade do |t|
    t.integer  "comment_life_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "upvote_houses", force: :cascade do |t|
    t.integer  "review_house_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "upvote_lives", force: :cascade do |t|
    t.integer  "review_life_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "user_infos", force: :cascade do |t|
    t.string   "nickname"
    t.integer  "birth"
    t.integer  "occupation"
    t.integer  "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
