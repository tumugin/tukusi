class Api::ProfilesController < Api::ApplicationController
  before_action :authenticate_admin_user!

  def show
    render json: current_admin_user, serializer: Api::AdminUserSerializer
  end

  def update
    admin_user = Api::UpdateProfileForm
                 .new(id: current_admin_user.id, **update_profile_params)
                 .save!
    render json: admin_user, serializer: Api::AdminUserSerializer
  end

  private

  def update_profile_params
    params.require(:admin_user).permit(%i[name email password])
  end
end
