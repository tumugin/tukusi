class Api::Subscriptions::PerformCrawlsController < Api::ApplicationController
  def create
    subscription = Subscription.find(params[:subscription_id])
    subscription.perform_crawler_job_later
    render json: {}
  end
end
