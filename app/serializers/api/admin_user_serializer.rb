class Api::AdminUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :user_level, :created_at
end
