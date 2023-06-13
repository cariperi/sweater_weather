class Api::V0::RoadTripController < ApplicationController
  before_action :verify_api_key, only: [:create]
  before_action :check_params, only: [:create]

  def create
    road_trip = RoadTripFacade.new.get_road_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def verify_api_key
    api_key = ApiKey.find_by(token: params[:api_key])
    return unless api_key.nil?

    render_unauthorized_response
  end

  def check_params
    return unless params[:origin].nil? || params[:destination].nil?

    render_missing_params_response
  end
end
