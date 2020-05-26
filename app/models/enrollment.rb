class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true
  validates :review, :rating, presence: true

  validates_uniqueness_of :user_id, scope: :course_id #cant be subscribed twice
  validates_uniqueness_of :course_id, scope: :user_id

  validate :owner_cant_subscribe


  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    user.to_s + " " + course.to_s
  end
  
  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  protected

  def owner_cant_subscribe
    if self.new_record?
      if user_id == course.user_id
        errors.add(:base, "You can't subscribe to your own course")
      end
    end
  end

  
end
