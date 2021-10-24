class Api::MetaController < Api::ApplicationController
  def show
    render json: Util::HashCamelCaseConverter.convert({ csrf_token: form_authenticity_token })
  end
end
