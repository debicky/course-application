class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user, :course, presence: true

  validates_uniqueness_of :user_id, scope: :course_id #cant be subscribed twice
  validates_uniqueness_of :course_id, scope: :user_id

  validate :owner_cant_subscribe

  def to_s
    user.to_s + course.to_s
  end

  protected

  def owner_cant_subscribe
    if self.new_record?
      if user_id == course.user_id
        errors.add(:base, "You can't subscribe to your own course")
      end
    end
  end

  
end
