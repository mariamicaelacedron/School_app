class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles disponibles
  enum :role, { user: 0, admin: 1 }, default: :user

  # Asignar rol por defecto
  after_initialize :set_default_role, if: :new_record?
  has_many :grades
  has_many :grades_received, class_name: 'Grade', foreign_key: 'user_id'
  has_many :grades_assigned, class_name: 'Grade', foreign_key: 'admin_id'
  has_one :student

  private

  def set_default_role
    self.role ||= :user
  end
end