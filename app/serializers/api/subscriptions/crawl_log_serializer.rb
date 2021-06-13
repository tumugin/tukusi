class Api::Subscriptions::CrawlLogSerializer < ActiveModel::Serializer
  attributes :duration, :result, :started_at,
             :ended_at, :captured_data
end
