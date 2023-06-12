class Api::V0::ForecastController < ApplicationController
  def search
    forecast = ForecastFacade.new.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end
