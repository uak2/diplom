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

ActiveRecord::Schema.define(version: 20160218095722) do

  create_table "address_passports", force: :cascade do |t|
    t.integer  "address_id",  null: false
    t.integer  "passport_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "address_passports", ["address_id"], name: "index_address_passports_on_address_id"
  add_index "address_passports", ["passport_id"], name: "index_address_passports_on_passport_id"

  create_table "addresses", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["person_id"], name: "index_addresses_on_person_id"

  create_table "fibs", force: :cascade do |t|
    t.integer  "people_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fibs", ["people_id"], name: "index_fibs_on_people_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "passports", force: :cascade do |t|
    t.integer  "series"
    t.string   "number"
    t.string   "code_subdivision", limit: 100, null: false
    t.datetime "date_extradition",             null: false
    t.string   "passport_issued",  limit: 255, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "passports", ["number"], name: "index_passports_on_number"

  create_table "people", force: :cascade do |t|
    t.string   "first_name",  limit: 50, null: false
    t.string   "second_name", limit: 50
    t.string   "last_name",   limit: 50
    t.datetime "birthday",               null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "speciality_id",               null: false
    t.string   "specialization", limit: 255,  null: false
    t.datetime "start_study",                 null: false
    t.datetime "end_study",                   null: false
    t.text     "note",           limit: 2048
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "plans", ["speciality_id"], name: "index_plans_on_speciality_id"

  create_table "role_users", force: :cascade do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "role_users", ["role_id"], name: "index_role_users_on_role_id"
  add_index "role_users", ["user_id"], name: "index_role_users_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.integer  "role_number"
    t.string   "role_title",  limit: 30, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "roles", ["role_number"], name: "index_roles_on_role_number"

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

  add_index "specialities", ["form_number"], name: "index_specialities_on_form_number"
  add_index "specialities", ["level_number"], name: "index_specialities_on_level_number"
  add_index "specialities", ["number"], name: "index_specialities_on_number"

  create_table "student_periods", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.integer  "term_id",    null: false
    t.integer  "plan_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "student_periods", ["group_id"], name: "index_student_periods_on_group_id"
  add_index "student_periods", ["plan_id"], name: "index_student_periods_on_plan_id"
  add_index "student_periods", ["student_id"], name: "index_student_periods_on_student_id"
  add_index "student_periods", ["term_id"], name: "index_student_periods_on_term_id"

  create_table "students", force: :cascade do |t|
    t.datetime "ducket_date"
    t.integer  "ducket_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "subdivision_groups", force: :cascade do |t|
    t.integer  "subdivision_id", null: false
    t.integer  "group_id",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subdivision_groups", ["group_id"], name: "index_subdivision_groups_on_group_id"
  add_index "subdivision_groups", ["subdivision_id"], name: "index_subdivision_groups_on_subdivision_id"

  create_table "subdivisions", force: :cascade do |t|
    t.integer  "type_number",             null: false
    t.string   "type_title",  limit: 100
    t.string   "institution", limit: 255, null: false
    t.string   "chairisting", limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "subdivisions", ["type_number"], name: "index_subdivisions_on_type_number"

  create_table "terms", force: :cascade do |t|
    t.datetime "start_term", null: false
    t.datetime "end_term",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",           limit: 30,  null: false
    t.string   "password_digest", limit: 300, null: false
    t.datetime "last_login"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["login"], name: "index_users_on_login"

  create_table "years", force: :cascade do |t|
    t.datetime "date"
  end

end
