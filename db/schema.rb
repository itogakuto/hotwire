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

ActiveRecord::Schema[8.1].define(version: 2026_08_16_114415) do
  create_table "employee_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_level", default: 0, null: false
    t.integer "employee_id", null: false
    t.integer "experience_months", default: 0, null: false
    t.boolean "manager_verified", default: false, null: false
    t.boolean "practical_experience", default: false, null: false
    t.boolean "self_assessed", default: true, null: false
    t.integer "skill_id", null: false
    t.integer "target_level"
    t.datetime "updated_at", null: false
    t.index ["employee_id", "skill_id"], name: "index_employee_skills_on_employee_id_and_skill_id", unique: true
    t.index ["employee_id"], name: "index_employee_skills_on_employee_id"
    t.index ["skill_id"], name: "index_employee_skills_on_skill_id"
    t.check_constraint "current_level BETWEEN 0 AND 5", name: "employee_skills_current_level_range"
    t.check_constraint "experience_months >= 0", name: "employee_skills_experience_months_non_negative"
    t.check_constraint "target_level IS NULL OR target_level BETWEEN 0 AND 5", name: "employee_skills_target_level_range"
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "current_project"
    t.string "desired_role"
    t.text "experience_summary"
    t.string "grade"
    t.text "interests"
    t.string "name", null: false
    t.string "role"
    t.integer "team_id", null: false
    t.datetime "updated_at", null: false
    t.integer "years_of_experience"
    t.index ["team_id", "name"], name: "index_employees_on_team_id_and_name"
    t.index ["team_id"], name: "index_employees_on_team_id"
    t.check_constraint "years_of_experience >= 0", name: "employees_years_of_experience_non_negative"
  end

  create_table "skill_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skill_categories_on_name", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "important", default: false, null: false
    t.string "name", null: false
    t.integer "skill_category_id", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_category_id", "name"], name: "index_skills_on_skill_category_id_and_name", unique: true
    t.index ["skill_category_id"], name: "index_skills_on_skill_category_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  add_foreign_key "employee_skills", "employees"
  add_foreign_key "employee_skills", "skills"
  add_foreign_key "employees", "teams"
  add_foreign_key "skills", "skill_categories"
end
