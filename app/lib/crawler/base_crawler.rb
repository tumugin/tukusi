class Crawler::BaseCrawler
  def timeout_seconds_or_nil
    # 0秒はタイムアウトしない設定にする
    if timeout_seconds.zero?
      nil
    else
      timeout_seconds
    end
  end
end
