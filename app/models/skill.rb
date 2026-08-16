class Skill < ApplicationRecord
  belongs_to :skill_category

  has_many :employee_skills, dependent: :destroy
  has_many :employees, through: :employee_skills

  validates :name,
    presence: true,
    uniqueness: { scope: :skill_category_id }

  scope :important, -> { where(important: true) }
end