class Api::AdminUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :user_level, :created_at
end
