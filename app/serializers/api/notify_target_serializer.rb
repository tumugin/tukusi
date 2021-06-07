class Api::NotifyTargetSerializer < ActiveModel::Serializer
  attributes :id, :name, :notify_type
  has_one :target_detail, serializer: Api::TargetDetailSerializer
end
