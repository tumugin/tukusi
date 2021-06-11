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
  # CSRFトークンのチェックをAuthorizationヘッダが付いていないときのみ行う(Cookie認証用)
  protect_from_forgery with: :exception, unless: -> { request.authorization }

  private

  def disable_session
    if request.authorization
      request.session_options[:skip] = true
    end
  end

  def disable_devise_trackable
    # devise5で直るはず...
    # ref: https://github.com/heartcombo/devise/pull/4987
    if request.authorization
      request.env['devise.skip_trackable'] = true
    end
  end
end
