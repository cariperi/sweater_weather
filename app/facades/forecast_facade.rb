class ForecastFacade
  def get_forecast(location)
    weather = get_weather(get_coordinates(location))
    Forecast.new(weather)
  end

  private

  def get_coordinates(location)
    GeocodeFacade.new.get_coordinates(location)
  end

  def get_weather(coordinates)
    WeatherFacade.new.get_weather(coordinates)
  end
end
