require 'rails_helper'

RSpec.describe WeatherFacade, :vcr do
  describe 'instance methods' do
    describe 'get_weather(coordinates)' do
      it 'returns a hash with weather forecast details for given coordinates' do
        coordinates = {lat: 39.74001, lon: -104.99202}
        weather = WeatherFacade.new.get_weather(coordinates)

        expect(weather).to be_a(Hash)
        keys = %i[current_weather daily_weather hourly_weather]
        keys.each do |key|
          expect(weather).to have_key(key)
        end

        current_weather = weather[:current_weather]
          expect(current_weather).to be_a(Hash)

          keys = %i[last_updated condition icon]
          keys.each do |key|
            expect(current_weather).to have_key(key)
            expect(current_weather[key]).to be_a(String)
          end

          keys = %i[temperature feels_like humidity uvi visibility]
          keys.each do |key|
            expect(current_weather).to have_key(key)
            expect(current_weather[key]).to be_a(Float)
          end

        daily_weather = weather[:daily_weather]
          expect(daily_weather).to be_an(Array)
          expect(daily_weather.count).to eq(5)
          string_keys = %i[date sunrise sunset condition icon]
          float_keys = %i[max_temp min_temp]

          daily_weather.each do |day|
            expect(day).to be_a(Hash)

            string_keys.each do |key|
              expect(day).to have_key(key)
              expect(day[key]).to be_a(String)
            end

            float_keys.each do |key|
              expect(day).to have_key(key)
              expect(day[key]).to be_a(Float)
            end
          end

        hourly_weather = weather[:hourly_weather]
          expect(hourly_weather).to be_an(Array)
          expect(hourly_weather.count).to eq(24)

          string_keys = %i[time conditions icon]

          hourly_weather.each do |hour|
            expect(hour).to be_a(Hash)

            string_keys.each do |key|
              expect(hour).to have_key(key)
              expect(hour[key]).to be_a(String)
            end

            expect(hour).to have_key(:temperature)
            expect(hour[:temperature]).to be_a(Float)
          end
      end
    end

    describe 'get_destination_forecast(destination, eta)' do
      it 'returns forecast weather data for a given place and date / hour' do
        destination = 'Chicago, IL'
        eta = { date: ((Date.today + 1.day)).to_s, hour: '05' }

        weather = WeatherFacade.new.get_destination_forecast(destination, eta)

        expect(weather).to be_a(Hash)
        expect(weather).to have_key(:datetime)
        expect(weather[:datetime]).to be_a(String)
        expect(weather).to have_key(:temperature)
        expect(weather[:temperature]).to be_a(Float)
        expect(weather).to have_key(:condition)
        expect(weather[:condition]).to be_a(String)
      end
    end
  end
end
