class Api::NotifyTargetSerializer < ActiveModel::Serializer
  attributes :name, :notify_type
  has_one :target_detail, serializer: Api::TargetDetailSerializer
end
