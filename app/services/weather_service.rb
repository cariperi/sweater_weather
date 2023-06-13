class WeatherService
  def get_weather(coordinates)
    get_url("/v1/forecast.json?q=#{coordinates[:lat]},#{coordinates[:lon]}&days=5")
  end

  def get_forecast(destination, eta)
    get_url("/v1/forecast.json?q=#{destination}&days=1&dt=#{eta[:date]}&hour=#{eta[:hour]}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = ENV['WEATHER_API_KEY']
    end
  end
end
