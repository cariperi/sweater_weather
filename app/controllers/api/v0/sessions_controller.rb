class Api::V0::SessionsController < ApplicationController
  before_action :check_params, only: [:create]
  before_action :find_user, only: [:create]

  def create
    @user.authenticate(params[:password]) ? render_valid_user_response : render_unauthorized_response
  end

  private

  def check_params
    return unless params[:email].nil? || params[:password].nil?

    render_missing_params_response
  end

  def find_user
    @user = User.find_by(email: params[:email].downcase)
    render_unauthorized_response if @user.nil?
  end

  def render_valid_user_response
    render json: UserSerializer.new(@user), status: 200
  end
end
