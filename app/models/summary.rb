class Summary < ApplicationRecord
  belongs_to :user

  validates :user, :week_start, :activities, :remarks, presence: true
  validates :participated, inclusion: { in: [ true, false ] }
end
