require 'rails_helper'

RSpec.describe NotifyTarget, type: :model do
  describe 'notify!' do
    it 'with Slack notify target' do
      notify_target = build(:notify_target, :notify_type_slack)
      stub_request(:post, notify_target.target_detail.webhook_url)
        .with(
          body: {
            payload: {
              text: nil,
              attachments: [{
                fallback: 'hoge message',
                title: 'hoge',
                text: 'hoge message',
                color: 'good'
              }]
            }.to_json
          }
        )
      notify_target.notify!(
        title: 'hoge',
        attachment_title: 'hoge title',
        attachment_message: 'hoge message',
        success: true
      )
    end
  end
end
