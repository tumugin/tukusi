class Api::Auth::LoginsController < Api::ApplicationController
  prepend_before_action :allow_params_authentication!, only: :create

  def create
    sign_out scope
    resource = warden.authenticate!(auth_options)
    sign_in(scope, resource)
    token = Warden::JWTAuth::UserEncoder
              .new
              .call(current_admin_user, scope, nil)
              .first
    render json: { token: token }
  end

  private

  def auth_options
    { scope: scope, store: true }
  end

  def scope
    :admin_user
  end
end
