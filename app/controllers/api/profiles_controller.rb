class Api::ProfilesController < Api::ApplicationController
  def show
    render json: current_admin_user, serializer: Api::AdminUserSerializer
  end
end
