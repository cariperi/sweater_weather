class BookSearch
  attr_reader :destination,
              :forecast,
              :total_books_found,
              :books,
              :id

  def initialize(forecast, books)
    @id = nil
    @destination = books[:destination]
    @forecast = forecast
    @total_books_found = books[:total_books_found]
    @books = books[:books]
  end
end
