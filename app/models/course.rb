class Course < ApplicationRecord
  belongs_to :user
  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :description, length: {minimum: 5}
  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  LANGUAGES = [ :"English", :"Polish", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language]}
  end

  LEVELS = [ :"Beginner", :"Intermediate", :"Advanced"]
  def self.levels
    LEVELS.map { |level| [level, level]}
  end
  
end
