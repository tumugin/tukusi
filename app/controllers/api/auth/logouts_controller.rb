class Api::Auth::LogoutsController < Api::ApplicationController
  before_action :authenticate_admin_user!

  def create
    sign_out :admin_user
    render json: {}
  end
end
