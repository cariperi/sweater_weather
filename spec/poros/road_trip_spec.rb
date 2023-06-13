require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialization' do
    it 'exists and has attributes' do
      origin = 'Cincinnati, OH'
      destination = 'Chicago, IL'
      time = 7980
      weather = { datetime: '2023-04-07 23:00', temperature: 44.2, condition: 'Cloudy' }

      road_trip = RoadTrip.new(origin, destination, time, weather)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)

      weather = road_trip.weather_at_eta
      expect(weather).to have_key(:datetime)
      expect(weather).to have_key(:temperature)
      expect(weather).to have_key(:condition)
    end
  end

  describe 'instance methods' do
    it 'formats time in seconds to a string with hours and minutes' do
      origin = 'Cincinnati, OH'
      destination = 'Chicago, IL'
      time = 7980
      weather = { datetime: '2023-04-07 23:00', temperature: 44.2, condition: 'Cloudy' }

      road_trip = RoadTrip.new(origin, destination, time, weather)

      expect(road_trip.format_time(time)).to eq('2h 13m')
    end
  end
end
