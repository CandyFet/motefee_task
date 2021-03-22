class Api::V1::ApplicationController < Api::ApplicationController
  def render_error(message, status)
    render json: { error: true, message: I18n.t(message, defaul: message) }, status: status
  end
end
