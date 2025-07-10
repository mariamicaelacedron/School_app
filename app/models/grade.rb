class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :admin, class_name: "User"

  validates :user_id, :subject, :score, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
