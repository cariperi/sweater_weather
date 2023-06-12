require 'rails_helper'

RSpec.describe BookSearchFacade, :vcr do
  describe 'instance methods' do
    describe 'get_details(location, quantity)' do
      it 'creates a book_search object for a given city and quantity' do
        location = 'Denver, CO'
        quantity = '5'
        book_search = BookSearchFacade.new.get_details(location, quantity)

        expect(book_search).to be_a(BookSearch)
        expect(book_search.destination).to be_a(String)
        expect(book_search.forecast).to be_a(Hash)
        expect(book_search.total_books_found).to be_a(Integer)
        expect(book_search.books).to be_an(Array)
        expect(book_search.books.count).to eq(5)
      end
    end
  end
end
