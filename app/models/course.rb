class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :title, :description, :short_description, :language, :price, :level, presence: true

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_rich_text :description
  has_many :enrollments

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
  
  def bought(user)
    self.enrollments.where(user_id: [user.id], course_id: [self.id].empty?)
  end
  


end
