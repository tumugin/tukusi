class Jobs::CrawlLogForm
  include ActiveModel::Model

  attr_accessor :id, :duration, :result, :started_at,
                :ended_at, :captured_data, :subscription

  validates :id, numericality: { only_integer: true }, allow_nil: true
  validates :duration, numericality: true, allow_nil: true
  validates :result, presence: true, inclusion: { in: CrawlLog::RESULTS }
  validates :started_at, presence: true
  validates :ended_at, presence: true, allow_nil: true
  validates :captured_data, presence: true, allow_nil: true
  validates :subscription, presence: true, if: -> { id.nil? }

  def save!
    validate!

    if id.nil?
      crawl_log = CrawlLog.new
      crawl_log.subscription = subscription
    else
      crawl_log = CrawlLog.find(id)
    end

    crawl_log.assign_attributes(
      duration: duration,
      result: result,
      started_at: started_at,
      ended_at: ended_at,
      captured_data: captured_data
    )

    crawl_log.save!

    crawl_log
  end
end
