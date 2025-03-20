# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_18_044222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interview_sections", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.string "body"
    t.decimal "llm_fee", precision: 15, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_interview_sections_on_topic_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "interview_section_id", null: false
    t.string "body"
    t.decimal "llm_fee", precision: 15, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interview_section_id"], name: "index_questions_on_interview_section_id"
  end

  create_table "topics", force: :cascade do |t|
    t.text "body"
    t.decimal "llm_fee", precision: 15, scale: 7
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "interview_sections", "topics"
  add_foreign_key "questions", "interview_sections"
end
