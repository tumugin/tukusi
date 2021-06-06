class ApplicationController < ActionController::Base
  # JSON APIに対してはCSRFトークンの検証を無効化する
  protect_from_forgery unless: -> { request.format.json? }
end
