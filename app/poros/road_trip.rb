class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, time, weather)
    @id = 'null'
    @start_city = origin
    @end_city = destination
    @travel_time = format_time(time)
    @weather_at_eta = weather
  end

  def format_time(time)
    return time if time.is_a?(String)

    "#{time.div(3600)}h #{(time % 3600).div(60)}m"
  end
end
