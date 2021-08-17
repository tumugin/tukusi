require 'nokogiri'
require 'open-uri'

class Crawler::NokogiriCrawler < Crawler::BaseCrawler
  attr_accessor :url, :selector, :timeout_seconds

  def initialize(params = {})
    @url = params[:url]
    @selector = params[:selector]
    @timeout_seconds = params[:timeout_seconds]
  end

  # @return String
  def perform!
    document = Nokogiri::HTML(URI.open(url, read_timeout: timeout_seconds_or_nil))
    elements = document.css(selector)
    raise '指定されたセレクタの要素が存在しません' if elements.empty?

    elements.first.text
  end
end
