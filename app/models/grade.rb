class Grade < ApplicationRecord
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  validates :score, presence: true, numericality: { in: 0..10 }
  validates :subject, :comment, presence: true

  scope :by_student, ->(student_id) { where(student_id: student_id) }
  scope :recent, -> { order(created_at: :desc) }
end