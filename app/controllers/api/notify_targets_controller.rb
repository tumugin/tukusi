class Api::NotifyTargetsController < Api::ApplicationController
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
    notify_target = Api::CreateNotifyTargetForm
                      .new({
                             **notify_target_params,
                             admin_user_id: current_admin_user.id,
                             target_detail: Api::CreateSlackNotifyTargetForm.new(notify_target_detail)
                           })
                      .save!
    render json: notify_target
  end

  def update
    notify_target = Api::UpdateNotifyTargetForm
                      .new({
                             **notify_target_params,
                             target_detail: Api::UpdateSlackNotifyTargetForm.new(notify_target_detail),
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
