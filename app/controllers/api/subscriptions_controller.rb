class Api::SubscriptionsController < Api::ApplicationController
  def index
    subscriptions = Subscription
                      .page(params[:page] || 1)
    render json: subscriptions
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: subscription
  end

  def create

  end

  def update

  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.destroy!
  end
end
