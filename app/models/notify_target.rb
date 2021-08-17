require 'slack-notifier'

class NotifyTarget < ApplicationRecord
  belongs_to :admin_user
  has_one :slack_notify_target, dependent: :destroy
  has_many :notify_targets_of_subscriptions
  has_many :subscriptions, through: :notify_targets_of_subscriptions

  NOTIFY_TYPE_SLACK = 'slack'.freeze
  NOTIFY_TYPES = [
    NOTIFY_TYPE_SLACK
  ].freeze

  # 通知先の詳細を取得する
  # N+1クエリになってしまうので不必要に使用しないこと
  # @return SlackNotifyTarget 通知先がSlackの場合
  def target_detail
    case notify_type
    when NOTIFY_TYPE_SLACK
      slack_notify_target
    else
      raise '未実装の通知先です'
    end
  end

  # 通知を送信する
  # @param [Hash] opts
  # @option opts [String] :title 通知タイトル
  # @option opts [String] :attachment_title 通知タイトル(アタッチメント)
  # @option opts [String] :attachment_message 通知メッセージ(アタッチメント)
  # @option opts [Boolean] :success 成功したかどうか
  def notify!(opts)
    case notify_type
    when NOTIFY_TYPE_SLACK
      # Slack通知処理
      attachment = {
        fallback: opts[:attachment_message],
        title: opts[:title],
        text: opts[:attachment_message],
        color: opts[:success] ? 'good' : 'danger'
      }
      Slack::Notifier
        .new(target_detail.webhook_url)
        .post(
          text: opts[:message], attachments: [attachment]
        )
    else
      raise '未実装の通知処理です'
    end
  end
end
