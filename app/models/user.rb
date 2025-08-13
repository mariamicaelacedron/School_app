class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1 }, default: :user

  after_initialize :set_default_role, if: :new_record?
  validates :description, length: { maximum: 500 }
  validate :avatar_content_type
  validates :name, presence: true, on: :update
  validate :avatar_size_and_type
  validate :validate_avatar

  has_many :grades, dependent: :destroy
  has_many :grades_received, class_name: "Grade", foreign_key: "user_id", dependent: :destroy
  has_many :grades_assigned, class_name: "Grade", foreign_key: "admin_id", dependent: :nullify
  has_many :summaries_received, class_name: "Summary", foreign_key: "user_id", dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users
  has_many :attendances, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
    attachable.variant :medium, resize_to_limit: [ 300, 300 ]
    attachable.variant :large, resize_to_limit: [ 500, 500 ]
  end
  private
  def validate_avatar
    return unless avatar.attached?

    # Validación de tamaño
    if avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "es demasiado grande (máximo 5MB)")
      avatar.purge # Elimina el archivo adjunto no válido
    end

    # Validación de tipo de contenido
    acceptable_types = ["image/jpeg", "image/png", "image/gif"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "debe ser una imagen JPEG, PNG o GIF")
      avatar.purge # Elimina el archivo adjunto no válido
    end
  end

  def self.permitted_params
    [ :name, :role, :email, :password, :password_confirmation, :invitation_token ]
  end
  def avatar_content_type
    return unless avatar.attached?

    unless avatar.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:avatar, "debe ser una imagen JPEG, PNG o GIF")
    end
  end

  def avatar_size_and_type
    return unless avatar.attached?

    # Validación de tipo (5MB máximo)
    if avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "es demasiado grande (máximo 5MB)")
    end

    # Validación de tipo
    acceptable_types = [ "image/jpeg", "image/png", "image/gif" ]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "debe ser JPEG, PNG o GIF")
    end
  end
  def set_default_role
    self.role ||= :user
  end
end
