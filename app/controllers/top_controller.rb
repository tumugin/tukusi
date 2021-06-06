class TopController < ApplicationController
  def index
    render json: { error: 'not found.' }, status: 404
  end
end
