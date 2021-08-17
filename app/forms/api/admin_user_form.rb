class Api::AdminUserForm
  include ActiveModel::Model

  attr_accessor :id, :name, :user_level, :email, :password

  validates :id, presence: true, numericality: { only_integer: true }, allow_nil: true
  validates :name, presence: true, length: { minimum: 1 }
  validates :user_level, presence: true, inclusion: { in: AdminUser::USER_LEVELS }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, strong_password: true, if: :needs_validate_password

  def needs_validate_password
    id.nil?
  end

  def get_admin_user
    if id.nil?
      AdminUser.new(
        jti: SecureRandom.uuid
      )
    else
      AdminUser.find(id)
    end
  end

  def save!
    validate!
    admin_user = get_admin_user
    admin_user
      .assign_attributes(
        name: name,
        user_level: user_level,
        email: email,
      )
    if password.presence
      admin_user.password = password
    end
    admin_user.skip_confirmation!
    admin_user.save!
    admin_user
  end
end
