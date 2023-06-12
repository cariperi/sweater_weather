require 'rails_helper'

RSpec.describe GeocodeService do
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
