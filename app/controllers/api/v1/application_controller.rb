class Api::V1::ApplicationController < Api::ApplicationController
  def render_error(message, status)
    render json: { error: true, message: message }, status: status
  end
end