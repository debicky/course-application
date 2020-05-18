class Course < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true
  validates :description, length: {minimum: 5}
  has_rich_text :description
end
