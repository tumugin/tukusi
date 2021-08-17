require 'jsonpath'
require 'json'

class Crawler::JsonCrawler < Crawler::BaseCrawler
  attr_accessor :url, :selector, :timeout_seconds

  def initialize(params = {})
    @url = params[:url]
    @selector = params[:selector]
    @timeout_seconds = params[:timeout_seconds]
    super()
  end

  # @return String
  def perform!
    plain_json = URI.open(url, read_timeout: timeout_seconds_or_nil).read
    parsed_json = JSON.parse(plain_json)
    JsonPath.new(selector).on(parsed_json).to_json
  end
end
