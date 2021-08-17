class Api::UpdateProfileForm
  include ActiveModel::Model

  attr_accessor :id, :name, :email, :password

  validates :id, presence: true, numericality: { only_integer: true }
  validates :name, presence: true, length: { minimum: 1 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, strong_password: true, allow_nil: true

  def save!
    validate!
    admin_user = AdminUser.find(id)
    admin_user
      .assign_attributes(
        name: name,
        email: email
      )
    admin_user.password = password if password.presence
    admin_user.skip_confirmation!
    admin_user.save!
    admin_user
  end
end
