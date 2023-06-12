require 'rails_helper'

RSpec.describe 'Get Weather for a City', :vcr do
  describe 'Happy Paths' do
    it 'returns weather information for a specific location' do
      location = 'Denver, CO'

      get "/api/v0/forecast?location=#{location}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)

      forecast = data[:data]
      expect(forecast).to be_a(Hash)

      expect(forecast).to have_key(:id)
      expect(forecast[:id]).to be(nil)

      expect(forecast).to have_key(:type)
      expect(forecast[:type]).to be_a(String)
      expect(forecast[:type]).to eq('forecast')

      expect(forecast).to have_key(:attributes)
      expect(forecast[:attributes]).to be_a(Hash)

      attributes = forecast[:attributes]
      expect(attributes).to have_key(:current_weather)
      expect(attributes[:current_weather]).to be_a(Hash)
      expect(attributes).to have_key(:daily_weather)
      expect(attributes[:daily_weather]).to be_an(Array)
      expect(attributes).to have_key(:hourly_weather)
      expect(attributes[:hourly_weather]).to be_an(Array)

      current_weather = attributes[:current_weather]

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

      do_not_include_keys = %i[wind pressure cloud gust]
      do_not_include_keys.each do |key|
        expect(current_weather).to_not have_key(key)
      end

      daily_weather = attributes[:daily_weather]
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

      hourly_weather = attributes[:hourly_weather]
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

  describe 'Sad Paths' do
    xit 'returns an error code and message if a location is not provided' do
      location = ''

      get "/api/v0/forecast?location=#{location}"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:error)
      expect(data[:error]).to be('No forecast information is available for the requested location.')
    end

    xit 'returns an error code and message if the provided location is not valid' do
      location = 'A wrong location'

      get "/api/v0/forecast?location=#{location}"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:error)
      expect(data[:error]).to be('No forecast information is available for the requested location.')
    end
  end
end
