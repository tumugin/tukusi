class Api::SessionsController < Devise::SessionsController
  respond_to :json

  # 無効化しても設定されるSessionのクッキーを強制的に切る
  after_action -> { request.session_options[:skip] = true }

  def create
    self.resource = warden.authenticate!(auth_options)
    render json: { token: current_token }
  end

  protected def auth_options
    # session storeを利用しない
    super.merge(store: false)
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
