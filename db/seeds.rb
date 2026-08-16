def find_or_update(model, lookup, attributes = {})
  record = model.find_or_initialize_by(lookup)
  record.assign_attributes(attributes)
  record.save!
  record
end

teams = {}

["プラットフォーム開発部", "業務アプリ開発部"].each do |name|
  teams[name] = find_or_update(Team, { name: name })
end

categories = {}

["Web開発", "クラウド", "データ", "マネジメント"].each do |name|
  categories[name] = find_or_update(SkillCategory, { name: name })
end

skills = {}

[
  ["Rails", "Web開発", true],
  ["Java", "Web開発", true],
  ["AWS", "クラウド", true],
  ["Docker", "クラウド", false],
  ["SQL", "データ", true],
  ["PM", "マネジメント", true]
].each do |name, category_name, important|
  skills[name] = find_or_update(
    Skill,
    {
      skill_category: categories.fetch(category_name),
      name: name
    },
    {
      important: important
    }
  )
end

employees = {}

[
  {
    name: "佐藤 花子",
    team: "プラットフォーム開発部",
    role: "テックリード",
    grade: "L3",
    years_of_experience: 8,
    current_project: "顧客ポータル刷新",
    experience_summary: "Webアプリケーションの設計と開発",
    desired_role: "エンジニアリングマネージャー",
    interests: "クラウドアーキテクチャ"
  },
  {
    name: "鈴木 健",
    team: "プラットフォーム開発部",
    role: "バックエンドエンジニア",
    grade: "L2",
    years_of_experience: 5,
    current_project: "顧客ポータル刷新",
    experience_summary: "Railsによる業務システム開発",
    desired_role: "テックリード",
    interests: "AWS、設計"
  },
  {
    name: "高橋 美咲",
    team: "プラットフォーム開発部",
    role: "クラウドエンジニア",
    grade: "L2",
    years_of_experience: 4,
    current_project: "クラウド移行",
    experience_summary: "AWS基盤構築とコンテナ運用",
    desired_role: "クラウドアーキテクト",
    interests: "SRE、セキュリティ"
  },
  {
    name: "田中 優",
    team: "プラットフォーム開発部",
    role: "アプリケーションエンジニア",
    grade: "L1",
    years_of_experience: 2,
    current_project: "社内ツール改善",
    experience_summary: "小規模機能の実装",
    desired_role: "バックエンドエンジニア",
    interests: "Rails、データベース"
  },
  {
    name: "伊藤 翔",
    team: "業務アプリ開発部",
    role: "Javaエンジニア",
    grade: "L3",
    years_of_experience: 7,
    current_project: "基幹システム更新",
    experience_summary: "Javaによる基幹システム開発",
    desired_role: "アーキテクト",
    interests: "システム設計"
  },
  {
    name: "山本 葵",
    team: "業務アプリ開発部",
    role: "プロジェクトマネージャー",
    grade: "M1",
    years_of_experience: 9,
    current_project: "基幹システム更新",
    experience_summary: "複数プロジェクトの計画と推進",
    desired_role: "プログラムマネージャー",
    interests: "組織開発、育成"
  }
].each do |attributes|
  name = attributes.fetch(:name)
  team = teams.fetch(attributes.fetch(:team))

  employees[name] = find_or_update(
    Employee,
    { team: team, name: name },
    attributes.except(:name, :team)
  )
end

# 社員名、スキル名、現在レベル、目標レベル、実務経験、
# 経験月数、上司確認済み、最終更新からの月数
assignments = [
  ["佐藤 花子", "Rails", 4, 5, true, 72, true, 1],
  ["佐藤 花子", "SQL", 4, 4, true, 60, true, 1],
  ["佐藤 花子", "AWS", 3, 4, true, 30, true, 2],
  ["佐藤 花子", "PM", 2, 3, false, 12, false, 2],

  ["鈴木 健", "Rails", 3, 4, true, 36, true, 8],
  ["鈴木 健", "SQL", 3, 4, true, 30, true, 2],
  ["鈴木 健", "AWS", 1, 3, false, 3, false, 2],
  ["鈴木 健", "Docker", 2, 3, true, 12, false, 3],

  ["高橋 美咲", "AWS", 4, 5, true, 48, true, 1],
  ["高橋 美咲", "Docker", 4, 5, true, 42, true, 1],
  ["高橋 美咲", "SQL", 3, 4, true, 24, true, 2],
  ["高橋 美咲", "Rails", 2, 3, false, 8, false, 3],

  ["田中 優", "Rails", 2, 3, true, 10, false, 5],
  ["田中 優", "SQL", 2, 3, false, 6, false, 4],
  ["田中 優", "Docker", 1, 2, false, 2, false, 3],

  ["伊藤 翔", "Java", 4, 5, true, 72, true, 7],
  ["伊藤 翔", "SQL", 4, 4, true, 60, true, 2],
  ["伊藤 翔", "PM", 2, 3, true, 18, false, 3],

  ["山本 葵", "PM", 4, 5, true, 84, true, 1],
  ["山本 葵", "Java", 2, 3, true, 20, false, 2],
  ["山本 葵", "SQL", 2, 3, true, 24, false, 2]
]

assignments.each do |
  employee_name,
  skill_name,
  current_level,
  target_level,
  practical_experience,
  experience_months,
  manager_verified,
  months_since_update
|
  employee_skill = EmployeeSkill.find_or_initialize_by(
    employee: employees.fetch(employee_name),
    skill: skills.fetch(skill_name)
  )

  employee_skill.update!(
    current_level: current_level,
    target_level: target_level,
    practical_experience: practical_experience,
    experience_months: experience_months,
    self_assessed: true,
    manager_verified: manager_verified
  )

  employee_skill.update_column(
    :updated_at,
    months_since_update.months.ago
  )
end

puts "Teams: #{Team.count}"
puts "Employees: #{Employee.count}"
puts "Categories: #{SkillCategory.count}"
puts "Skills: #{Skill.count}"
puts "Employee skills: #{EmployeeSkill.count}"