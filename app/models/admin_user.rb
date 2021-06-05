class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  USER_LEVEL_ADMINISTRATOR = 'administrator'
  USER_LEVEL_SUPERVISOR = 'supervisor'
  USER_LEVELS = [
    USER_LEVEL_ADMINISTRATOR,
    USER_LEVEL_SUPERVISOR,
  ]

  def is_user_administrator
    user_level == USER_LEVEL_ADMINISTRATOR
  end

  def is_user_supervisor
    user_level == USER_LEVEL_SUPERVISOR
  end
end
