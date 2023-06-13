require 'rails_helper'

RSpec.describe RoadTripFacade, :vcr do
  describe 'instance methods' do
    describe 'get_road_trip(origin, destination)' do
      it 'creates a road trip object for a given origin and destination' do
        origin = 'Cincinnati, OH'
        destination = 'Chicago, IL'
        road_trip = RoadTripFacade.new.get_road_trip(origin, destination)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq('Cincinnati, OH')
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq('Chicago, IL')
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash)

        keys = %i[datetime temperature condition]
        keys.each do |key|
          expect(road_trip.weather_at_eta).to have_key(key)
        end
      end
    end
  end
end
