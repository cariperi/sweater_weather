require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  describe 'instance methods' do
    describe 'get_forecast(location)' do
      it 'creates a forecast object for a given location' do
        location = 'Denver, CO'
        forecast = ForecastFacade.new.get_forecast(location)

        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a(Hash)
        expect(forecast.daily_weather).to be_an(Array)
        expect(forecast.daily_weather.count).to eq(5)
        expect(forecast.hourly_weather).to be_an(Array)
        expect(forecast.hourly_weather.count).to eq(24)
      end
    end
  end
end
