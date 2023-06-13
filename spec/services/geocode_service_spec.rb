require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'instance methods' do
    describe 'get_coordinates' do
      it 'returns coordinates', :vcr do
        service = GeocodeService.new
        response = service.get_coordinates('Denver, CO')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:results)
        expect(response[:results]).to be_an(Array)

        result_location = response[:results][0]
        expect(result_location).to be_a(Hash)
        expect(result_location).to have_key(:locations)

        location = result_location[:locations][0]
        expect(location).to be_a(Hash)
        expect(location).to have_key(:latLng)

        coordinates = location[:latLng]
        expect(coordinates).to be_a(Hash)
        expect(coordinates[:lat]).to be_a(Float)
        expect(coordinates[:lng]).to be_a(Float)
      end
    end

    describe 'get_travel_time' do
      it 'returns travel time', :vcr do
        service = GeocodeService.new
        response = service.get_travel_time('Cincinnati, OH', 'Chicago, IL')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:info)
        expect(response[:info]).to be_a(Hash)
        expect(response[:info][:statuscode]).to eq(0)
        expect(response[:info][:messages]).to be_an(Array)
        expect(response[:info][:messages]).to be_empty

        expect(response).to have_key(:route)
        expect(response[:route]).to be_a(Hash)

        route = response[:route]
        expect(route).to have_key(:time)
        expect(route[:time]).to be_an(Integer)
      end

      it 'returns a string value if travel is impossible', :vcr do
        service = GeocodeService.new
        response = service.get_travel_time('New York, NY', 'London, England')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:info)
        expect(response[:info]).to be_a(Hash)
        expect(response[:info][:statuscode]).to eq(402)
        expect(response[:info][:messages]).to be_an(Array)
        expect(response[:info][:messages]).to_not be_empty

        expect(response).to have_key(:route)
        expect(response[:route]).to be_a(Hash)
      end
    end
  end
end
