class Api::Subscriptions::SubscriptionsController < Api::ApplicationController
  before_action :authenticate_admin_user!

  def index
    subscriptions = Subscription
                      .preload(:notify_targets)
                      .page(params[:page] || 1)
    render json: subscriptions
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: subscription
  end

  def create
    subscription = Api::SubscriptionForm.new(admin_user: current_admin_user, **subscription_params).save!
    render json: subscription
  end

  def update
    subscription = Api::SubscriptionForm.new(id: params[:id], **subscription_params).save!
    render json: subscription
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.destroy!
  end

  private

  def subscription_params
    params[:subscription].permit(
      :enabled,
      :name,
      :check_interval_seconds,
      :timeout_seconds,
      :target_url,
      :target_selector,
      :subscription_type,
      notify_target_ids: [],
    )
  end
end
