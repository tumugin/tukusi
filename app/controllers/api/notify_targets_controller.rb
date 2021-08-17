class Api::NotifyTargetsController < Api::ApplicationController
  before_action :authenticate_admin_user!

  def index
    notify_targets = NotifyTarget
                       .eager_load(:slack_notify_target)
                       .page(params[:page] || 1)
    render json: notify_targets
  end

  def show
    notify_target = NotifyTarget.find(params[:id])
    render json: notify_target
  end

  def create
    notify_target = Api::NotifyTargetForm
                      .new({
                             **notify_target_params,
                             admin_user: current_admin_user,
                             target_detail: Api::SlackNotifyTargetForm.new(notify_target_detail)
                           })
                      .save!
    render json: notify_target
  end

  def update
    notify_target = Api::NotifyTargetForm
                      .new({
                             **notify_target_params,
                             target_detail: Api::SlackNotifyTargetForm.new(notify_target_detail),
                             id: params[:id]
                           })
                      .save!
    render json: notify_target
  end

  def destroy
    NotifyTarget.find(params[:id]).destroy!
  end

  private

  def notify_target_params
    params.require(:notify_target).permit(:name, :notify_type)
  end

  def notify_target_detail
    params.require(:notify_target_detail).permit(:webhook_url)
  end
end
