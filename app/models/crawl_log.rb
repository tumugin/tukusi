class CrawlLog < ApplicationRecord
  belongs_to :subscription

  RESULT_RUNNING = 'running'.freeze
  RESULT_FAILED = 'failed'.freeze
  RESULT_SUCCESS = 'success'.freeze
  RESULT_NOTIFY_FAILED = 'notify_failed'.freeze
  RESULTS = [
    RESULT_RUNNING,
    RESULT_FAILED,
    RESULT_NOTIFY_FAILED,
    RESULT_SUCCESS,
  ].freeze
end
