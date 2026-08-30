class CreateEmployeeSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :employee_skills do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :current_level, null: false, default: 0
      t.integer :target_level
      t.boolean :practical_experience, null: false, default: false
      t.integer :experience_months, null: false, default: 0
      t.boolean :self_assessed, null: false, default: true
      t.boolean :manager_verified, null: false, default: false

      t.timestamps
    end
    add_index :employee_skills,
      [ :employee_id, :skill_id ],
      unique: true

    add_check_constraint :employee_skills,
      "current_level BETWEEN 0 AND 5",
      name: "employee_skills_current_level_range"

    add_check_constraint :employee_skills,
      "target_level IS NULL OR target_level BETWEEN 0 AND 5",
      name: "employee_skills_target_level_range"

    add_check_constraint :employee_skills,
      "experience_months >= 0",
      name: "employee_skills_experience_months_non_negative"
  end
end
