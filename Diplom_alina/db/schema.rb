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

ActiveRecord::Schema.define(version: 20160324054535) do

  create_table "address_passports", force: :cascade do |t|
    t.integer  "address_id",  null: false
    t.integer  "passport_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.integer  "a_type",     null: false
    t.string   "address",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["a_type"], name: "index_addresses_on_a_type"
  add_index "addresses", ["person_id"], name: "index_addresses_on_person_id"

  create_table "change_lists", force: :cascade do |t|
    t.string   "m_type",     null: false
    t.integer  "person_id",  null: false
    t.integer  "old_id",     null: false
    t.integer  "new_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "change_lists", ["m_type"], name: "index_change_lists_on_m_type"
  add_index "change_lists", ["new_id"], name: "index_change_lists_on_new_id"
  add_index "change_lists", ["old_id"], name: "index_change_lists_on_old_id"
  add_index "change_lists", ["person_id"], name: "index_change_lists_on_person_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "passports", force: :cascade do |t|
    t.integer  "person_id",                                  null: false
    t.integer  "series"
    t.string   "number"
    t.string   "code_subdivision", limit: 100,               null: false
    t.datetime "date_extradition",                           null: false
    t.string   "passport_issued",  limit: 255,               null: false
    t.string   "sex",              limit: 1,   default: "m", null: false
    t.datetime "birthday",                                   null: false
    t.string   "birth_city",                                 null: false
    t.string   "first_name",       limit: 50,                null: false
    t.string   "second_name",      limit: 50,                null: false
    t.string   "last_name",        limit: 50,                null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "passports", ["first_name"], name: "index_passports_on_first_name"
  add_index "passports", ["last_name"], name: "index_passports_on_last_name"
  add_index "passports", ["number"], name: "index_passports_on_number"
  add_index "passports", ["person_id"], name: "index_passports_on_person_id"
  add_index "passports", ["second_name"], name: "index_passports_on_second_name"

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "person_id",          null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "photos", ["person_id"], name: "index_photos_on_person_id"

  create_table "plans", force: :cascade do |t|
    t.integer  "speciality_id",               null: false
    t.string   "specialization", limit: 255,  null: false
    t.datetime "start_study",                 null: false
    t.datetime "end_study",                   null: false
    t.text     "note",           limit: 2048
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "role_users", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "role_number"
    t.string   "role_title",  limit: 30, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.integer  "number",                   null: false
    t.string   "name",         limit: 100, null: false
    t.integer  "form_number",              null: false
    t.string   "form_name",    limit: 100, null: false
    t.string   "level_name",   limit: 100, null: false
    t.integer  "level_number",             null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "student_periods", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.integer  "term_id",    null: false
    t.integer  "plan_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "ducket_date",   null: false
    t.integer  "ducket_number"
    t.integer  "person_id",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "students", ["person_id"], name: "index_students_on_person_id"

  create_table "subdivision_groups", force: :cascade do |t|
    t.integer  "subdivision_id", null: false
    t.integer  "group_id",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "subdivisions", force: :cascade do |t|
    t.integer  "type_number",             null: false
    t.string   "type_title",  limit: 100
    t.string   "institution", limit: 255, null: false
    t.string   "chairisting", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "terms", force: :cascade do |t|
    t.datetime "start_term", null: false
    t.datetime "end_term",   null: false
    t.integer  "year_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "terms", ["year_id"], name: "index_terms_on_year_id"

  create_table "users", force: :cascade do |t|
    t.string   "login",           limit: 30,  null: false
    t.string   "password_digest", limit: 300, null: false
    t.datetime "last_login"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "years", force: :cascade do |t|
    t.datetime "start_year", null: false
    t.datetime "end_year",   null: false
  end

end
