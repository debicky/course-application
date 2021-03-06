class Course < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates :title, :description, :short_description, :language, :price, :level, presence: true
  validates :title, uniqueness: true
  validates :logo, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 500.kilobytes , message: 'Maximum size is 500 kilobytes.' }
  validates :short_description, length: { minimum: 5}
  validates :description, length: { maximum: 3000}
  validates :title, length: { maximum: 100}
  validates :price, numericality: {greater_than_or_equal_to: 0}
  
  belongs_to :user, counter_cache: true
  has_many :lessons, dependent: :destroy
  has_rich_text :description
  has_many :enrollments, dependent: :restrict_with_error
  has_many :user_lessons, through: :lessons
  has_one_attached :logo
  #User.find_each { |user| User.reset_counters(user.id, :courses)}

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

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
    self.enrollments.where(user_id: [user.id], course_id: [self.id]).any?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end

  def progress(user)
    unless self.lessons_count == 0
      user_lessons.where(user: user).count/self.lessons_count.to_f*100
    end
  end
  


end
