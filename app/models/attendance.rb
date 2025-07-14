class Attendance < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :date, presence: true
  validates :status, presence: true

  enum :status, {
    present: "present",
    absent: "absent",
    late: "late"
  }, default: "present"
end
