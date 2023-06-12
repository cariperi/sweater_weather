require 'rails_helper'

RSpec.describe Forecast do
  describe 'initialization' do
    it 'exists and has attributes' do
      attributes = {current_weather: {}, daily_weather: [], hourly_weather: []}

      forecast = Forecast.new(attributes)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to eq({})
      expect(forecast.daily_weather).to eq([])
      expect(forecast.hourly_weather).to eq([])
    end
  end
end
