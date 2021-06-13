require 'open-uri'

class Crawler::PlainCrawler < Crawler::BaseCrawler
  attr_accessor :url, :timeout_seconds

  def initialize(params = {})
    @url = params[:url]
    @timeout_seconds = params[:timeout_seconds]
  end

  # @return String
  def perform!
    URI.open(url, read_timeout: timeout_seconds_or_nil).read
  end
end