require 'rails_helper'

RSpec.describe LibraryService do
  it 'returns data about documents matching a keyword', :vcr do
    service = LibraryService.new
    response = service.get_books('Denver, CO', '5')

    expect(response).to be_a(Hash)
    expect(response).to have_key(:start)
    expect(response).to have_key(:num_found)
    expect(response).to have_key(:docs)

    expect(response[:docs]).to be_an(Array)
    expect(response[:docs].count).to eq(5)

    expect(response).to have_key(:q)
    expect(response[:q]).to eq('Denver, CO')
  end
end
