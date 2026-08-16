class CockpitController < ApplicationController
  def index
    @teams = Team.order(:name)
    @categories = SkillCategory.order(:name)

    @selected_team =
      if params[:team_id].present?
        @teams.find_by(id: params[:team_id])
      else
        @teams.first
      end

    skills_scope =
      Skill
        .joins(:skill_category)
        .includes(:skill_category)
        .order("skill_categories.name ASC", "skills.name ASC")

    if params[:category_id].present?
      skills_scope =
        skills_scope.where(skill_category_id: params[:category_id])
    end

    query = params[:query].to_s.strip

    if query.present?
      escaped_query = Skill.sanitize_sql_like(query)

      skills_scope =
        skills_scope.where(
          "skills.name LIKE ?",
          "%#{escaped_query}%"
        )
    end

    @skills = skills_scope.to_a

    @employees =
      if @selected_team
        @selected_team.employees.order(:name).to_a
      else
        []
      end

    employee_ids = @employees.map(&:id)
    skill_ids = @skills.map(&:id)

    @employee_skill_map =
      EmployeeSkill
        .where(employee_id: employee_ids, skill_id: skill_ids)
        .index_by { |employee_skill|
          [employee_skill.employee_id, employee_skill.skill_id]
        }

    team_skill_records =
      EmployeeSkill.where(employee_id: employee_ids)

    @member_count = @employees.length

    @registered_skill_count =
      team_skill_records.distinct.count(:skill_id)

    @stale_employee_count =
      team_skill_records
        .stale
        .distinct
        .count(:employee_id)

    @dependency_risk_count =
      team_skill_records
        .joins(:skill)
        .where(
          practical_experience: true,
          current_level: 3..5,
          skills: { important: true }
        )
        .group(:skill_id)
        .having(
          "COUNT(DISTINCT employee_skills.employee_id) = 1"
        )
        .count
        .length
  end
end