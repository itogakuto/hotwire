class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name, null: false
      t.string :role
      t.string :grade
      t.integer :years_of_experience
      t.string :current_project
      t.text :experience_summary
      t.string :desired_role
      t.text :interests

      t.timestamps
    end
    add_index :employees, [ :team_id, :name ]
    add_check_constraint :employees,
      "years_of_experience >= 0",
      name: "employees_years_of_experience_non_negative"
  end
end
