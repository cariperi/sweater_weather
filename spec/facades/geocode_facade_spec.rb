require 'rails_helper'

RSpec.describe GeocodeFacade, :vcr do
  describe 'instance methods' do
    describe 'get_coordinates(location)' do
      it 'returns a hash with the lat and lon for a city' do
        location = 'Denver, CO'
        coordinates = GeocodeFacade.new.get_coordinates(location)

        expect(coordinates).to be_a(Hash)
        expect(coordinates).to have_key(:lat)
        expect(coordinates[:lat]).to be_a(Float)
        expect(coordinates).to have_key(:lon)
        expect(coordinates[:lon]).to be_a(Float)
      end
    end
  end
end
