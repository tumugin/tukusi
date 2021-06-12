class NotifyTarget < ApplicationRecord
  belongs_to :admin_user
  has_one :slack_notify_target, dependent: :destroy
  has_many :notify_targets_of_subscriptions
  has_many :subscriptions, through: :notify_targets_of_subscriptions

  NOTIFY_TYPE_SLACK = 'slack'
  NOTIFY_TYPES = [NOTIFY_TYPE_SLACK]

  # 通知先の詳細を取得する
  # N+1クエリになってしまうので不必要に使用しないこと
  # @return SlackNotifyTarget 通知先がSlackの場合
  # @return nil 通知先が何らかの理由によって存在しない場合(DBに不整合が生じない限り無い)
  def target_detail
    case notify_type
    when NOTIFY_TYPE_SLACK then
      return slack_notify_target
    else
      return nil
    end
  end

  # 通知を送信する
  # @param [Hash] opts
  # @option opts [String] :title 通知タイトル
  # @option opts [String] :attachment_title 通知タイトル(アタッチメント)
  # @option opts [String] :attachment_message 通知メッセージ(アタッチメント)
  def notify!(opts)
    case notify_type
    when NOTIFY_TYPE_SLACK
      # Slack通知処理
    else
      raise '未実装の通知処理です'
    end
  end
end
