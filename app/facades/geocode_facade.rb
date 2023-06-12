class GeocodeFacade
  def get_coordinates(location)
    format_data(coordinate_data(location))
  end

  private

  def service
    @_service ||= GeocodeService.new
  end

  def coordinate_data(location)
    @_coordinate_data ||= service.get_coordinates(location)
  end

  def format_data(data)
    coordinates = data[:results][0][:locations][0][:latLng]

    {
      lat: coordinates[:lat],
      lon: coordinates[:lng]
    }
  end
end
