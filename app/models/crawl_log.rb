class CrawlLog < ApplicationRecord
  belongs_to :subscription

  RESULT_RUNNING = 'running'
  RESULT_FAILED = 'failed'
  RESULT_SUCCESS = 'success'
  RESULT_NOTIFY_FAILED = 'notify_failed'
  RESULTS = [
    RESULT_RUNNING,
    RESULT_FAILED,
    RESULT_NOTIFY_FAILED,
    RESULT_SUCCESS,
  ]
end
