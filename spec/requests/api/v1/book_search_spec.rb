require 'rails_helper'

RSpec.describe 'Get Books for a City', :vcr do
  describe 'Happy Paths' do
    it 'returns book and forecast information for a specific destination city' do
      location = 'Denver, CO'
      quantity = '5'

      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)

      info = data[:data]
      expect(info).to be_a(Hash)

      expect(info).to have_key(:id)
      expect(info[:id]).to be(nil)

      expect(info).to have_key(:type)
      expect(info[:type]).to be_a(String)
      expect(info[:type]).to eq('books')

      expect(info).to have_key(:attributes)
      expect(info[:attributes]).to be_a(Hash)

      attributes = info[:attributes]

      expect(attributes).to have_key(:destination)
      expect(attributes[:destination]).to be_a(String)
      expect(attributes[:destination]).to eq(location)


      expect(attributes).to have_key(:forecast)
      expect(attributes[:forecast]).to be_a(Hash)
      keys = %i[summary temperature]
      keys.each do |key|
        expect(attributes[:forecast]).to have_key(key)
        expect(attributes[key]).to be_a(String)
      end

      expect(attributes).to have_key(:total_books_found)
      expect(attributes[:total_books_found]).to be_an(Integer)

      expect(attributes).to have_key(:books)
      expect(attributes[:books]).to be_an(Array)
      expect(attributes[:books].count).to eq(quantity)

      books = attributes[:books]
      books.each do |book|
        expect(book).to be_a(Hash)
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an(Array)
        expect(book[:isbn][0]).to be_a(String)
        expect(book).to have_key(:title)
        expect(book[:title]).to be_a(String)
        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an(Array)
        expect(book[:publisher][0]).to be_a(String)
      end
    end
  end
end
