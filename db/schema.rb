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

ActiveRecord::Schema.define(version: 20151230234606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mentor_skills", force: :cascade do |t|
    t.integer  "mentor_id",  null: false
    t.integer  "skill_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mentor_skills", ["mentor_id", "skill_id"], name: "index_mentor_skills_on_mentor_id_and_skill_id", unique: true, using: :btree

  create_table "mentors", force: :cascade do |t|
    t.string   "name",                                         null: false
    t.string   "email",                                        null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",              default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                        default: false
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
  end

  add_index "mentors", ["confirmation_token"], name: "index_mentors_on_confirmation_token", unique: true, using: :btree
  add_index "mentors", ["email"], name: "index_mentors_on_email", unique: true, using: :btree
  add_index "mentors", ["reset_password_token"], name: "index_mentors_on_reset_password_token", unique: true, using: :btree
  add_index "mentors", ["unlock_token"], name: "index_mentors_on_unlock_token", unique: true, using: :btree

  create_table "skill_proposals", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "proposed_by", null: false
    t.integer  "reviewed_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "skill_proposals", ["proposed_by"], name: "index_skill_proposals_on_proposed_by", using: :btree
  add_index "skill_proposals", ["reviewed_by"], name: "index_skill_proposals_on_reviewed_by", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
