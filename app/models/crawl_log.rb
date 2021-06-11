class CrawlLog < ApplicationRecord
  belongs_to :subscription

  RESULT_RUNNING = 'running'
  RESULT_FAILED = 'failed'
  RESULT_SUCCESS = 'success'
  RESULTS = [
    RESULT_RUNNING,
    RESULT_FAILED,
    RESULT_SUCCESS,
  ]
end
