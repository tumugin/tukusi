class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :target_url, null: false
      t.string :target_selector
      t.integer :timeout_seconds, null: false
      t.string :subscription_type, null: false
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :crawl_logs do |t|
      t.integer :duration
      t.string :result, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.string :captured_data
      t.timestamps

      t.belongs_to :subscription
    end

    create_table :notify_targets do |t|
      t.string :notify_type, null: false
      t.integer :target_id, null: false
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :slack_notify_targets do |t|
      t.string :webhook_url, null: false
      t.timestamps

      t.belongs_to :notify_target
    end

    create_table :notify_targets_of_subscriptions, id: false do |t|
      t.belongs_to :subscription
      t.belongs_to :notify_target
    end
  end
end
