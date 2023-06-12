class Api::V0::ForecastController < ApplicationController
  before_action :check_for_location, only: [:search]

  def search
    forecast = ForecastFacade.new.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  private

  def check_for_location
    return unless params[:location].empty?

    render json: { errors: [{ detail: 'No forecast information is available for the requested location.' }] }, status: 400
  end
end
