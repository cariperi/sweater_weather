class LibraryFacade
  def get_books(location, quantity)
    format_data(book_data(location, quantity))
  end

  private

  def service
    @_service ||= LibraryService.new
  end

  def book_data(location, quantity)
    @_book_data ||= service.get_books(location, quantity)
  end

  def format_data(data)
    books = []
    data[:docs].each do |doc|
      details = { isbn: doc[:isbn],
                  title: doc[:title],
                  publisher: doc[:publisher] }

      books << details
    end

    { destination: data[:q],
      total_books_found: data[:numFound],
      books: books }
  end
end
