class Api::ApplicationController < ActionController::API
  # Authorizationヘッダが付いているリクエストに関してはDeviseのtrackableを無効化する
  before_action :disable_devise_trackable
  # Sessionを無効化する
  before_action :disable_session

  private

  def disable_session
    request.session_options[:skip] = true
  end

  def disable_devise_trackable
    # devise5で直るはず...
    # ref: https://github.com/heartcombo/devise/pull/4987
    if request.authorization
      request.env['devise.skip_trackable'] = true
    end
  end
end
