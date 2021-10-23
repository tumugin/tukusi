class Api::Subscriptions::PerformCrawlsController < Api::ApplicationController
  before_action :authenticate_admin_user!

  def create
    subscription = Subscription.find(params[:subscription_id])
    subscription.perform_crawler_job_later
    render json: {}
  end
end
