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

ActiveRecord::Schema.define(version: 20170903064935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "submissions", force: :cascade do |t|
    t.string "problem_judge"
    t.string "problem_id"
    t.integer "verdict"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trainee_id"
  end

  create_table "tracked_verdicts", force: :cascade do |t|
    t.boolean "submission_error", default: true
    t.boolean "cant_be_judged", default: true
    t.boolean "in_queue", default: true
    t.boolean "compile_error", default: true
    t.boolean "restricted_function", default: true
    t.boolean "runtime_error", default: true
    t.boolean "output_limit", default: true
    t.boolean "time_limit", default: true
    t.boolean "memory_limit", default: true
    t.boolean "wrong_answer", default: true
    t.boolean "presentation_error", default: true
    t.boolean "accepted", default: true
    t.integer "trainee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainees", force: :cascade do |t|
    t.string "uva_handle"
    t.string "live_archive_handle"
    t.string "codeforces_handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tracking_status", default: 0
    t.string "name"
  end

end
