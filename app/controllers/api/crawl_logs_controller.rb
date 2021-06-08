class Api::CrawlLogsController < Api::ApplicationController
  def index
    crawl_logs = subscription.crawl_logs.page(params[:page] || 1)
    render json: crawl_logs
  end

  def show
    crawl_log = subscription.crawl_logs.find(params[:id])
    render json: crawl_log
  end

  private

  def subscription
    @subscription ||= Subscription.find(params[:subscription_id])
    @subscription
  end
end
