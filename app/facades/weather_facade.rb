class WeatherFacade
  def get_weather(coordinates)
    format_data(weather_data(coordinates))
  end

  def get_current_forecast(coordinates)
    format_day_data(weather_data(coordinates))
  end

  private

  def service
    @_service ||= WeatherService.new
  end

  def weather_data(coordinates)
    @_weather_data ||= service.get_weather(coordinates)
  end

  def format_data(data)
    current_weather = format_current(data[:current])
    daily_weather = format_daily(data[:forecast][:forecastday])
    hourly_weather = format_hourly(data[:forecast][:forecastday][0][:hour])

    { current_weather:, daily_weather:, hourly_weather: }
  end

  def format_day_data(data)
    temp = "#{data[:current][:temp_f].to_i} F"

    { summary: data[:current][:condition][:text],
      temperature: temp }
  end

  def format_current(data)
    { last_updated: data[:last_updated],
      condition: data[:condition][:text],
      icon: data[:condition][:icon],
      temperature: data[:temp_f],
      feels_like: data[:feelslike_f],
      humidity: data[:humidity].to_f,
      uvi: data[:uv],
      visibility: data[:vis_miles] }
  end

  def format_daily(data)
    data.map do |day_data|
      { date: day_data[:date],
        sunrise: day_data[:astro][:sunrise],
        sunset: day_data[:astro][:sunset],
        condition: day_data[:day][:condition][:text],
        icon: day_data[:day][:condition][:icon],
        max_temp: day_data[:day][:maxtemp_f],
        min_temp: day_data[:day][:mintemp_f] }
    end
  end

  def format_hourly(data)
    data.map do |hour_data|
      { time: hour_data[:time],
        conditions: hour_data[:condition][:text],
        icon: hour_data[:condition][:icon],
        temperature: hour_data[:temp_f] }
    end
  end
end
