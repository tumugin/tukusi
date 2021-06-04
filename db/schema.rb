# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_02_192955) do

  create_table "admin_users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti", null: false
    t.index ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["jti"], name: "index_admin_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
  end

  create_table "crawl_logs", force: :cascade do |t|
    t.integer "duration"
    t.string "result"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "subscription_id"
    t.index ["subscription_id"], name: "index_crawl_logs_on_subscription_id"
  end

  create_table "notify_targets", force: :cascade do |t|
    t.string "notify_type"
    t.integer "target_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_user_id"
    t.index ["admin_user_id"], name: "index_notify_targets_on_admin_user_id"
  end

  create_table "notify_targets_of_subscriptions", id: false, force: :cascade do |t|
    t.integer "subscription_id"
    t.integer "notify_target_id"
    t.index ["notify_target_id"], name: "index_notify_targets_of_subscriptions_on_notify_target_id"
    t.index ["subscription_id"], name: "index_notify_targets_of_subscriptions_on_subscription_id"
  end

  create_table "slack_notify_targets", force: :cascade do |t|
    t.string "webhook_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "notify_target_id"
    t.index ["notify_target_id"], name: "index_slack_notify_targets_on_notify_target_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "target_url"
    t.string "target_html_selector"
    t.integer "timeout_seconds"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_user_id"
    t.index ["admin_user_id"], name: "index_subscriptions_on_admin_user_id"
  end

end
