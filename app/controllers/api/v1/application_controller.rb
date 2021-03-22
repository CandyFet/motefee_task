class Api::V1::ApplicationController < Api::ApplicationController
  def render_error(message, status)
    render json: { error: true, message: I18n.t(message, default: message) }, status: status
  end
end
