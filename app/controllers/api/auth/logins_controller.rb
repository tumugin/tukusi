class Api::Auth::LoginsController < Api::ApplicationController
  prepend_before_action :allow_params_authentication!, only: :create

  def create
    resource = warden.authenticate!(auth_options)
    sign_in(:admin_user, resource)
    token = Warden::JWTAuth::UserEncoder
              .new
              .call(current_admin_user, scope, nil)
              .first
    render json: { token: token }
  end

  private

  def auth_options
    { scope: scope, store: false }
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def scope
    :admin_user
  end
end
