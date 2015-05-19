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

ActiveRecord::Schema.define(version: 20150518083230) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_questions", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "question_id"
  end

  add_index "categories_questions", ["category_id"], name: "index_categories_questions_on_category_id"
  add_index "categories_questions", ["question_id"], name: "index_categories_questions_on_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.string   "answer_correct"
    t.string   "answer_wrong_1"
    t.string   "answer_wrong_2"
    t.string   "answer_wrong_3"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "rating"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "scores", ["category_id"], name: "index_scores_on_category_id"
  add_index "scores", ["user_id"], name: "index_scores_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.boolean  "creator",         default: false
  end

end
