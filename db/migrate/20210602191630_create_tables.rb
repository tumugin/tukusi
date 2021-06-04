class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :target_url
      t.string :target_html_selector
      t.integer :timeout_seconds
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :crawl_logs do |t|
      t.integer :duration
      t.string :result
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.timestamps

      t.belongs_to :subscription
    end

    create_table :notification_targets do |t|
      t.string :notification_type
      t.integer :target_id
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :slack_notification_targets do |t|
      t.string :webhook_url
      t.timestamps

      t.belongs_to :notification_target
    end

    create_table :notification_targets_of_subscriptions do |t|
      t.belongs_to :subscription
      t.belongs_to :notification_target
    end
  end
end
