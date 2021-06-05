class Api::CreateAdminUserForm
  include ActiveModel::Model

  attr_accessor :name, :user_level, :email, :password

  validates :name, presence: true, length: { minimum: 1 }
  validates :user_level, presence: true, inclusion: { in: AdminUser::USER_LEVELS }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, strong_password: true

  def save
    AdminUser.create!(
      :name => name,
      :user_level => user_level,
      :email => :email,
      :password => :password,
    )
  end
end
