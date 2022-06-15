class RoadTripFacade

  def self.get_roadtrip(roadtrip_hash)
    trip = MapquestService.get_directions(roadtrip_hash[:start_city], roadtrip_hash[:end_city])
    if trip[:info][:statuscode] != 0
      return :impossible
    end
    weather = OpenWeatherMapService.get_forecast(roadtrip_hash[:end_city])
    instantiation_hash = {start_city: roadtrip_hash[:start_city], end_city: roadtrip_hash[:end_city], weather_at_eta: find_weather_at_eta(weather, get_travel_time(trip)), travel_time: get_travel_time(trip) }
    RoadTrip.new(instantiation_hash)
  end

  def get_travel_time(trip)
    # returns seconds as an integer, or "impossible" if route is impossible
    if trip[:route][:time].class = integer
      return trip[:route][:time]
    else
      return "impossible"
    end
  end

  def find_weather_at_eta(forecast, duration)
    # if duration is impossible, returns an empty hash per spec
    # if duration is less than 48 hours, uses hourly orecast
    # elsif duration is less than 7 days, uses daily forecast
    # elsif somehow duration is more than 7 days... uses last dayof forecast.
    if duration == "impossible"
      return Hash.new
    elsif duration <= 172800
      index = duration/3600 - 1
      return forecast[:hourly][index]
    elsif duration <= 604800
      index = duration/86400 - 1
      return forecast[:daily][index]
    else
      return forecast[:daily].last
    end
  end

end
