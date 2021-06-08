class Api::ProfilesController < Api::ApplicationController
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
    params.require(:admin_user).permit([:name, :email, :password])
  end
end
