class Employee < ApplicationRecord
  belongs_to :team

  has_many :employee_skills, dependent: :destroy
  has_many :skills, through: :employee_skills

  validates :name, presence: true
  validates :years_of_experience,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
end
