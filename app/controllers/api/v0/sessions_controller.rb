class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    end
  end
end
