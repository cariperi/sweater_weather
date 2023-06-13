require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  describe 'Happy Paths' do
    it 'returns roadtrip + weather data for specific start and end points when a trip is possible' do
      VCR.use_cassette('request_happy_path_1', allow_playback_repeats: true) do
        user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password' )
        user.api_keys.create(token: 'test_key')

        params = { origin: 'Cincinnati, OH',
                  destination: 'Chicago, IL',
                  api_key: 'test_key' }

        post('/api/v0/road_trip', params:)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to be_a(Hash)
        expect(data).to have_key(:data)

        road_trip = data[:data]
        expect(road_trip).to be_a(Hash)

        expect(road_trip).to have_key(:id)
        expect(road_trip[:id]).to be_a(String)
        expect(road_trip[:id]).to eq('null')

        expect(road_trip).to have_key(:type)
        expect(road_trip[:type]).to be_a(String)
        expect(road_trip[:type]).to eq('road_trip')

        expect(road_trip).to have_key(:attributes)
        expect(road_trip[:attributes]).to be_a(Hash)

        attributes = road_trip[:attributes]
        expect(attributes).to have_key(:start_city)
        expect(attributes[:start_city]).to be_a(String)
        expect(attributes[:start_city]).to eq('Cincinnati, OH')

        expect(attributes).to have_key(:end_city)
        expect(attributes[:end_city]).to be_a(String)
        expect(attributes[:end_city]).to eq('Chicago, IL')

        expect(attributes).to have_key(:travel_time)
        expect(attributes[:travel_time]).to be_a(String)

        expect(attributes).to have_key(:weather_at_eta)
        expect(attributes[:weather_at_eta]).to be_a(Hash)

        weather = attributes[:weather_at_eta]
        expect(weather).to have_key(:datetime)
        expect(weather[:datetime]).to be_a(String)
        expect(weather).to have_key(:temperature)
        expect(weather[:temperature]).to be_a(Float)
        expect(weather).to have_key(:condition)
        expect(weather[:condition]).to be_a(String)
      end
    end

    xit 'returns roadtrip data with expected values when travel is impossible' do

    end
  end

  describe 'Sad Paths' do
    xit 'returns a 401 error and message when API key is not provided' do

    end

    xit 'returns a 401 error and message when incorrect API key is provided' do

    end

    xit 'returns a 400 error if origin is not provided' do

    end

    xit 'returns a 400 error if destination is not provided' do

    end
  end
end
