class AdminUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :jwt_authenticatable,
         # FIXME: API経由の操作で毎回updateが走るので無効化. Devise 5.0で直るらしいが...
         # :trackable,
         # 一旦今は要らないのでNullにしておく
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  USER_LEVEL_ADMINISTRATOR = 'administrator'.freeze
  USER_LEVEL_SUPERVISOR = 'supervisor'.freeze
  USER_LEVELS = [
    USER_LEVEL_ADMINISTRATOR,
    USER_LEVEL_SUPERVISOR
  ].freeze

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
