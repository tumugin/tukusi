require 'nokogiri'
require 'open-uri'

class Crawler::NokogiriCrawler
  attr_accessor :url, :selector, :timeout_seconds

  def initialize(params = {})
    @url = params[:url]
    @selector = params[:selector]
    @timeout_seconds = params[:timeout_seconds]
  end

  def timeout_seconds_or_nil
    # 0秒はタイムアウトしない設定にする
    if timeout_seconds == 0
      nil
    else
      timeout_seconds
    end
  end

  # @return String
  def perform
    document = Nokogiri::HTML(URI.open(url, read_timeout: timeout_seconds_or_nil))
    elements = document.css(selector)
    if elements.empty?
      raise "指定されたセレクタの要素が存在しません"
    end
    elements.first.to_html
  end
end
