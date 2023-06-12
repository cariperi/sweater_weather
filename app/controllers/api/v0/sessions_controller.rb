class Api::V0::SessionsController < ApplicationController
  before_action :check_params, only: [:create]
  before_action :find_user, only: [:create]

  def create
    @user.authenticate(params[:password]) ? render_valid_user_response : render_credential_error
  end

  private

  def check_params
    return unless params[:email].nil? || params[:password].nil?

    render json: { errors: [{ detail: 'All fields must be provided.' }] }, status: 400
  end

  def find_user
    @user = User.find_by(email: params[:email].downcase)
    render_credential_error if @user.nil?
  end

  def render_credential_error
    render json: { errors: [{ detail: 'The credentials provided are not valid.' }] }, status: 401
  end

  def render_valid_user_response
    render json: UserSerializer.new(@user), status: 200
  end
end
