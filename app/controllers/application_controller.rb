class ApplicationController < ActionController::API
  def render_missing_params_response
    render json: { errors: [{ detail: 'All fields must be provided.' }] }, status: 400
  end

  def render_unauthorized_response
    render json: { errors: [{ detail: 'Unauthorized request.' }] }, status: 401
  end
end
