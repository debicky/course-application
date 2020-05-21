class Course < ApplicationRecord
  include PublicActivity::Model
  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :description, length: {minimum: 5}
  belongs_to :user
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
  
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  def to_s
    
  end

end
