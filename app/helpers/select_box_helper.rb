# frozen_string_literal: true

module SelectBoxHelper
  def difficulty_level_collection
    Bug.difficulty_levels.keys.map { |difficulty_level| [difficulty_level.titleize, difficulty_level] }
  end

  def operating_system_collection
    Environment.operating_systems.keys.map { |operating_system| [operating_system.titleize, operating_system] }
  end

  def language_collection
    Environment.languages.keys.map { |language| [language.titleize, language] }
  end

  def database_collection
    Environment.databases.keys.map { |database| [database.titleize, database] }
  end

  def browser_collection
    Environment.browsers.keys.map { |browser| [browser.titleize, browser] }
  end

  def framework_collection
    Environment::FRAMEWORKS
  end
end
