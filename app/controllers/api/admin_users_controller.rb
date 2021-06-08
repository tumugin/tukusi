class Api::AdminUsersController < Api::ApplicationController
  def index
    admin_users = AdminUser.page(params[:page] || 1)
    render json: admin_users
  end

  def show
    admin_user = AdminUser.find(params[:id])
    render json: admin_user
  end

  def create
    admin_user = Api::AdminUserForm.new(admin_user_params).save!
    render json: admin_user
  end

  def update
    admin_user = Api::AdminUserForm
                   .new(id: params[:id], **admin_user_params)
                   .save!
    render json: admin_user
  end

  def destroy
    AdminUser.find(params[:id]).delete
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:name, :user_level, :email, :password)
  end
end
