class BookSearchFacade
  def get_details(location, quantity)
    forecast = get_current_forecast(get_coordinates(location))
    books = get_books(location, quantity)

    BookSearch.new(forecast, books)
  end

  private

  def get_coordinates(location)
    GeocodeFacade.new.get_coordinates(location)
  end

  def get_current_forecast(coordinates)
    WeatherFacade.new.get_current_forecast(coordinates)
  end

  def get_books(location, quantity)
    LibraryFacade.new.get_books(location, quantity)
  end
end
