require 'rails_helper'

RSpec.describe DirectionsFacade, :vcr do
  describe 'instance methods' do
    describe 'get_travel_time(origin, destination)' do
      it 'returns an integer value in seconds for the travel time between locations' do
        origin = 'Cincinnati, OH'
        destination = 'Chicago, IL'
        travel_time = DirectionsFacade.new.get_travel_time(origin, destination)

        expect(travel_time).to be_an(Integer)
      end

      it 'returns a string message if there is no route between the two locations' do
        origin = 'New York, NY'
        destination = 'London, England'
        travel_time = DirectionsFacade.new.get_travel_time(origin, destination)

        expect(travel_time).to be_a(String)
        expect(travel_time).to eq('Impossible route.')
      end
    end
  end
end
