class Api::V0::UsersController < ApplicationController
  before_action :check_params, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :render_error

  def create
    new_user = User.create!(format_email(user_params))
    assign_api_key(new_user)
    render json: UserSerializer.new(new_user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def check_params
    return unless params[:email].nil? || params[:password].nil? || params[:password_confirmation].nil?

    render json: { errors: [{ detail: 'All fields must be provided.' }] }, status: 400
  end

  def format_email(params)
    params[:email] = params[:email].downcase
    params
  end

  def assign_api_key(user)
    user.api_keys.create(token: SecureRandom.hex)
  end

  def render_error(exception)
    render json: { errors: [{ detail: exception.message }] }, status: 403
  end
end
