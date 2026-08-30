class EmployeeSkill < ApplicationRecord
  belongs_to :employee
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :employee_id }

  validates :current_level,
    inclusion: { in: 0..5 }

  validates :target_level,
    inclusion: { in: 0..5 },
    allow_nil: true

  validates :experience_months,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }

  scope :practically_experienced,
    -> { where(practical_experience: true) }

  scope :stale,
    ->(cutoff = 180.days.ago) {
      where("employee_skills.updated_at < ?", cutoff)
    }
end
