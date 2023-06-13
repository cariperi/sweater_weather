class DirectionsFacade
  def get_travel_time(origin, destination)
    format_data(travel_time_data(origin, destination))
  end

  private

  def service
    @_service ||= GeocodeService.new
  end

  def travel_time_data(origin, destination)
    @_travel_time_data ||= service.get_travel_time(origin, destination)
  end

  def format_data(data)
    if (data[:info][:statuscode]).zero?
      data[:route][:time]
    else
      'Impossible route.'
    end
  end
end
