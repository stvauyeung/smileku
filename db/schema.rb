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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131211024037) do

  create_table "comments", :force => true do |t|
    t.text     "body",       :limit => 255
    t.integer  "user_id"
    t.integer  "ku_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["followed_id"], :name => "index_followings_on_followed_id"
  add_index "followings", ["follower_id", "followed_id"], :name => "index_followings_on_follower_id_and_followed_id", :unique => true
  add_index "followings", ["follower_id"], :name => "index_followings_on_follower_id"

  create_table "kus", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "story_id"
    t.integer  "parent_id"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "kus", ["slug"], :name => "index_kus_on_slug"

  create_table "posts", :force => true do |t|
    t.text     "text",       :limit => 255
    t.string   "title"
    t.string   "header"
    t.string   "mrec"
    t.string   "photo_link"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "large_cover"
    t.string   "slug"
  end

  add_index "stories", ["slug"], :name => "index_stories_on_slug"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "token"
    t.string   "location"
    t.text     "bio"
    t.string   "website"
    t.string   "photo"
    t.boolean  "admin",           :default => false
  end

  create_table "votes", :force => true do |t|
    t.boolean  "value"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

end
