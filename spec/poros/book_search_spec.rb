require 'rails_helper'

RSpec.describe BookSearch do
  describe 'initialization' do
    it 'exists and has attributes' do
      forecast = { summary: 'Cloudy with a chance of meatballs',
                   temperature: '83 F'}

      books = {
                destination: 'Denver, CO',
                total_books_found: 123,
                books: [{ isbn: ['0762507845'],
                          title: 'A Title.',
                          publisher: ['A Publisher'] },
                        { isbn: ['205938900'],
                          title: 'Another Title.',
                          publisher: ['Another Publisher'] }]
              }

      book_search = BookSearch.new(forecast, books)

      expect(book_search).to be_a(BookSearch)
      expect(book_search.destination).to eq('Denver, CO')
      expect(book_search.forecast).to eq(forecast)
      expect(book_search.total_books_found).to eq(123)
      expect(book_search.books).to be_an(Array)
      expect(book_search.books.count).to eq(2)
    end
  end
end
