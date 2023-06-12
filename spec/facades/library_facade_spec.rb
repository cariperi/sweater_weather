require 'rails_helper'

RSpec.describe LibraryFacade, :vcr do
  describe 'instance methods' do
    describe 'get_books(location, quantity)' do
      it 'returns a hash with total books and a books array' do
        location = 'Denver, CO'
        quantity = '5'

        result = LibraryFacade.new.get_books(location, quantity)

        expect(result).to be_a(Hash)
        expect(result).to have_key(:total_books_found)
        expect(result[:total_books_found]).to be_an(Integer)
        expect(result).to have_key(:books)
        expect(result[:books]).to be_an(Array)
        expect(result).to have_key(:destination)
        expect(result[:destination]).to be_a(String)
        expect(result[:destination]).to eq(location)

        books = result[:books]
        expect(books.count).to eq(5)
        books.each do |book|
          expect(book).to be_a(Hash)
          expect(book).to have_key(:isbn)
          expect(book[:isbn]).to be_an(Array) unless book[:isbn].nil?
          expect(book).to have_key(:title)
          expect(book[:title]).to be_a(String)
          expect(book).to have_key(:publisher)
          expect(book[:publisher]).to be_an(Array)
        end
      end
    end
  end
end
