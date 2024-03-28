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

ActiveRecord::Schema[7.0].define(version: 2023_04_19_190557) do
  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "credit_hours"
    t.string "has_lab"
    t.string "academic_career"
    t.integer "class_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "catalog_number"
    t.string "course_description"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string "instructor_email"
    t.string "student_email", null: false
    t.integer "rating"
    t.text "comments"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_evaluations_on_course_id"
  end

  create_table "instructor_recs", force: :cascade do |t|
    t.string "instructor_email", null: false
    t.boolean "specific_student_request_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason"
    t.integer "section_id"
    t.string "student_email"
  end

  create_table "section_instructors", force: :cascade do |t|
    t.integer "section_id", null: false
    t.string "instructor_email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_section_instructors_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "num_graders_needed", default: 1
    t.datetime "end_time"
    t.datetime "start_time"
    t.string "day"
    t.string "campus_name"
    t.string "term"
    t.string "is_in_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "student_apps", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "student_email", null: false
    t.string "campus_name", null: false
    t.string "term", null: false
    t.string "preferred_course", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_courses_takens", force: :cascade do |t|
    t.string "student_email", null: false
    t.integer "course", null: false
    t.string "grade", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_schedules", force: :cascade do |t|
    t.string "student_email", null: false
    t.string "day", null: false
    t.string "start_time", null: false
    t.string "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.boolean "approved", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "evaluations", "courses"
  add_foreign_key "evaluations", "users", column: "instructor_email", primary_key: "email", on_delete: :nullify
  add_foreign_key "evaluations", "users", column: "student_email", primary_key: "email"
  add_foreign_key "instructor_recs", "sections"
  add_foreign_key "instructor_recs", "users", column: "instructor_email", primary_key: "email"
  add_foreign_key "instructor_recs", "users", column: "student_email", primary_key: "email"
  add_foreign_key "section_instructors", "sections"
  add_foreign_key "section_instructors", "users", column: "instructor_email", primary_key: "email"
  add_foreign_key "sections", "courses"
  add_foreign_key "student_apps", "users", column: "student_email", primary_key: "email"
  add_foreign_key "student_courses_takens", "users", column: "student_email", primary_key: "email"
  add_foreign_key "student_schedules", "users", column: "student_email", primary_key: "email"
end
