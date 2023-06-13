class RoadTripFacade
  def get_road_trip(origin, destination)
    travel_time = get_travel_time(origin, destination)
    weather = get_destination_forecast(destination, get_eta(destination, travel_time))

    RoadTrip.new(origin, destination, travel_time, weather)
  end

  private

  def get_travel_time(origin, destination)
    DirectionsFacade.new.get_travel_time(origin, destination)
  end

  def get_destination_forecast(destination, eta)
    return {} if eta.is_a?(String)

    WeatherFacade.new.get_destination_forecast(destination, eta)
  end

  def get_eta(destination, time)
    return time if time.is_a?(String)

    coordinates = GeocodeFacade.new.get_coordinates(destination)
    timezone = Timezone.lookup(coordinates[:lat], coordinates[:lon])

    eta = timezone.utc_to_local(Time.now) + time
    { date: eta.strftime('%F'), hour: eta.strftime('%H') }
  end
end
