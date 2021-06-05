class NotifyTarget < ApplicationRecord
  belongs_to :admin_user
  has_many :subscriptions, through: :notify_targets_of_subscriptions

  NOTIFY_TYPE_SLACK = 'slack'
  NOTIFY_TYPES = [NOTIFY_TYPE_SLACK]

  # 通知先の詳細を取得する
  # N+1クエリになってしまうので不必要に使用しないこと
  # @return SlackNotifyTarget 通知先がSlackの場合
  # @return nil 通知先が何らかの理由によって存在しない場合(DBに不整合が生じない限り無い)
  def target_details
    case notify_type
    when NOTIFY_TYPE_SLACK then
      return SlackNotifyTarget.find(target_id)
    else
      return nil
    end
  end
end
