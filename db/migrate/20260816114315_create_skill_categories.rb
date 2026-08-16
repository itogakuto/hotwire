class CreateSkillCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :skill_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :skill_categories, :name
  end
end
