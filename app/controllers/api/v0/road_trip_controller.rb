class Api::V0::RoadTripController < ApplicationController
  before_action :verify_api_key, only: [:create]

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

  def render_unauthorized_response
    render json: { errors: [{ detail: 'Unauthorized.' }] }, status: 401
  end
end
