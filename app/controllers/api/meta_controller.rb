class Api::MetaController < Api::ApplicationController
  def show
    render json: { csrf_token: form_authenticity_token }
      .deep_stringify_keys
      .deep_transform_keys! { |key| key.camelize(:lower) }
  end
end
