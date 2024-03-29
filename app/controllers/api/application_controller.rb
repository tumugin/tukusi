class Api::ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  # active_model_serializersの挙動をカスタマイズするConcernを入れる
  include Api::PaginationConcern
  # すべてのパラメータをキャメルケースからスネークケースに変換するConcernを入れる
  include Api::CamelCaseParametersConcern
  # Authorizationヘッダが付いているリクエストに関してはDeviseのtrackableを無効化する
  before_action :disable_devise_trackable
  # Authorizationヘッダが付いているリクエストはSessionを無効化する
  before_action :disable_session
  # CSRFトークンのチェック(Cookie認証用)
  # トークンチェック失敗時にはリクエストのセッションが無効化される
  protect_from_forgery with: :null_session

  private

  def disable_session
    request.session_options[:skip] = true if request.authorization
  end

  def disable_devise_trackable
    # devise5で直るはず...
    # ref: https://github.com/heartcombo/devise/pull/4987
    request.env['devise.skip_trackable'] = true if request.authorization
  end
end
