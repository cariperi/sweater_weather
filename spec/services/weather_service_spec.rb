require 'rails_helper'

RSpec.describe WeatherService do
  describe 'instance methods' do
    describe 'get_weather' do
      it 'returns weather data', :vcr do
        service = WeatherService.new
        response = service.get_weather({lat: 39.74001, lon: -104.99202})

        expect(response).to be_a(Hash)
        expect(response).to have_key(:location)
        expect(response[:location]).to be_a(Hash)

        expect(response).to have_key(:current)
        expect(response[:current]).to be_a(Hash)

        current = response[:current]
        expect(current).to have_key(:last_updated)
        expect(current[:last_updated]).to be_a(String)

        float_keys = %i[temp_f feelslike_f vis_miles uv]
        float_keys.each do |key|
          expect(current).to have_key(key)
          expect(current[key]).to be_a(Float)
        end

        expect(current).to have_key(:humidity)
        expect(current[:humidity]).to be_an(Integer)

        expect(current).to have_key(:condition)
        expect(current[:condition]).to be_a(Hash)
        string_keys = %i[text icon]
        string_keys.each do |key|
          expect(current[:condition]).to have_key(key)
          expect(current[:condition][key]).to be_a(String)
        end

        expect(response).to have_key(:forecast)
        expect(response[:forecast]).to be_a(Hash)

        forecast = response[:forecast]
        expect(forecast[:forecastday]).to be_an(Array)

        days = forecast[:forecastday]
        expect(days.count).to eq(5)
        days.each do |day|
          expect(day).to be_a(Hash)
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(String)
          expect(day).to have_key(:day)
          expect(day[:day]).to be_a(Hash)

          details = day[:day]
            float_keys = %i[maxtemp_f mintemp_f]
            float_keys.each do |key|
              expect(details).to have_key(key)
              expect(details[key]).to be_a(Float)
            end
            expect(details).to have_key(:condition)
            expect(details[:condition]).to be_a(Hash)
            string_keys = %i[text icon]
            string_keys.each do |key|
              expect(details[:condition]).to have_key(key)
              expect(details[:condition][key]).to be_a(String)
            end

          expect(day).to have_key(:astro)
          string_keys = %i[sunrise sunset]
          string_keys.each do |key|
            expect(day[:astro]).to have_key(key)
            expect(day[:astro][key]).to be_a(String)
          end

          expect(day).to have_key(:hour)
          expect(day[:hour]).to be_a(Array)

          hours = day[:hour]
          expect(hours.count).to eq(24)

          hours.each do |hour|
            expect(hour).to be_a(Hash)
            keys = %i[time temp_f is_day condition]
            keys.each do |key|
              expect(hour).to have_key(key)
            end
          end
        end
      end
    end

    describe 'get_forecast' do
      it 'returns forecast data', :vcr do
        service = WeatherService.new
        destination = 'Chicago, IL'
        eta = { date: ((Date.today + 1.day)).to_s, hour: '05' }
        response = service.get_forecast(destination, eta)

        expect(response).to be_a(Hash)
        expect(response).to have_key(:forecast)
        expect(response[:forecast]).to be_a(Hash)

        forecast = response[:forecast]
        expect(forecast).to have_key(:forecastday)
        expect(forecast[:forecastday]).to be_an(Array)
        expect(forecast[:forecastday].count).to eq(1)

        forecast_day = forecast[:forecastday][0]
        expect(forecast_day).to be_a(Hash)
        expect(forecast_day).to have_key(:hour)
        expect(forecast_day[:hour]).to be_an(Array)
        expect(forecast_day[:hour].count).to eq(1)

        hour = forecast_day[:hour][0]
        expect(hour).to be_a(Hash)
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
        expect(hour).to have_key(:temp_f)
        expect(hour[:temp_f]).to be_a(Float)
        expect(hour).to have_key(:condition)
        expect(hour[:condition][:text]).to be_a(String)
      end
    end
  end
end
