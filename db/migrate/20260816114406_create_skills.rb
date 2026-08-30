class CreateSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :skills do |t|
      t.references :skill_category, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :important, null: false, default: false

      t.timestamps
    end
    add_index :skills, [ :skill_category_id, :name ]
  end
end
