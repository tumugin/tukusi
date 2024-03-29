class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.boolean :enabled, null: false
      t.integer :check_interval_seconds, null: false
      t.string :target_url, null: false
      t.string :target_selector
      t.integer :timeout_seconds, null: false
      t.string :subscription_type, null: false
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :crawl_logs do |t|
      t.float :duration
      t.string :result, null: false
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.text :captured_data
      t.timestamps

      t.belongs_to :subscription
    end

    create_table :notify_targets do |t|
      t.string :name, null: false
      t.string :notify_type, null: false
      t.timestamps

      t.belongs_to :admin_user
    end

    create_table :slack_notify_targets do |t|
      t.string :webhook_url, null: false
      t.timestamps

      t.belongs_to :notify_target
    end

    create_table :notify_targets_of_subscriptions, id: false do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.belongs_to :subscription
      t.belongs_to :notify_target
    end
  end
end
