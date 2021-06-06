class Api::UpdateAdminUserForm
  include ActiveModel::Model

  attr_accessor :id, :name, :user_level, :email, :password

  validates :name, length: { minimum: 1 }, allow_nil: true
  validates :user_level, inclusion: { in: AdminUser::USER_LEVELS }, allow_nil: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :password, strong_password: true, allow_nil: true

  def save!
    validate!
    admin_user = AdminUser.find(id)
    unless name.nil?
      admin_user.name = name
    end
    unless user_level.nil?
      admin_user.user_level = user_level
    end
    unless email.nil?
      admin_user.email = email
    end
    unless password.nil?
      admin_user.password = password
    end
    admin_user.save!
    admin_user
  end
end
