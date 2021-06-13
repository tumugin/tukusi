require 'open-uri'

class Crawler::PlainCrawler
  attr_accessor :url, :timeout_seconds

  def initialize(params = {})
    @url = params[:url]
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
  def perform!
    URI.open(url, read_timeout: timeout_seconds_or_nil).read
  end
end
