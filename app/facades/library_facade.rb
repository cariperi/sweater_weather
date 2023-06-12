class LibraryFacade
  def get_books(location, quantity)
    format_data(found_books(location, quantity))
  end

  private

  def service
    @_service ||= LibraryService.new
  end

  def found_books(location, quantity)
    @_book_data ||= service.get_books(location, quantity)
  end

  def format_data(data)
    { destination: data[:q],
      total_books_found: data[:numFound],
      books: format_book_details(data[:docs]) }
  end

  def format_book_details(books_data)
    books_data.map do |book|
      { isbn: book[:isbn], title: book[:title], publisher: book[:publisher] }
    end
  end
end
