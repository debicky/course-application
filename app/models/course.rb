class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :title, uniqueness: true
  
  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_rich_text :description
  has_many :enrollments

  #User.find_each { |user| User.reset_counters(user.id, :courses)}

  def to_s
    title
  end

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
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end
  


end
