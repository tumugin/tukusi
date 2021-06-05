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

  # 管理者ユーザが特権レベルを持っているかどうか
  # @return bool
  def is_user_administrator
    user_level == USER_LEVEL_ADMINISTRATOR
  end

  # 管理者ユーザが監督者レベルを持っているかどうか
  # @return bool
  def is_user_supervisor
    user_level == USER_LEVEL_SUPERVISOR
  end
end
