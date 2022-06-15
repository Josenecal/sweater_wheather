class RoadTripFacade

  def self.get_roadtrip(roadtrip_hash)
    trip = MapquestService.get_directions(roadtrip_hash[:start_city], roadtrip_hash[:end_city])
    if trip[:info][:statuscode] != 0
      trip = "impossible"
    end
    weather = ForecastFacade.get_forecast_json_from_location(roadtrip_hash[:end_city])
    instantiation_hash = {start_city: roadtrip_hash[:start_city], end_city: roadtrip_hash[:end_city], weather_at_eta: find_weather_at_eta(weather, get_travel_time(trip)), travel_time: get_travel_time(trip) }
    RoadTrip.new(instantiation_hash)
  end

  def self.get_travel_time(trip)
    # returns seconds as an integer, or "impossible" if route is impossible
    if trip == "impossible"
      return "impossible"
    elsif trip[:route][:time].class == Integer
      return trip[:route][:time]
    end
  end

  def self.find_weather_at_eta(forecast, duration)
    # if duration is impossible, returns an empty hash per spec
    # if duration is less than 48 hours, uses hourly orecast
    # elsif duration is less than 7 days, uses daily forecast
    # elsif somehow duration is more than 7 days... uses last dayof forecast.
    # Refactor - put this into the RoadTrip object
    # Refactor - SRP, break into two methods to determine which block to look in, and another to determine the right index and pull information.
    # Refactor - dry this up, too? 
    if duration == "impossible"
      return Hash.new
    elsif duration <= 172800
      index = duration/3600 - 1
      return {
        "temperature": forecast[:hourly][index][:temp],
        "conditions":  forecast[:hourly][index][:weather].first[:description]
      }
    elsif duration <= 604800
      index = duration/86400 - 1
      return {
        "temperature": forecast[:daily][index][:temp][:day],
        "conditions":  forecast[:daily][index][:weather].first[:description]
      }
    else
      return {
        "temperature": forecast[:daily].last[:temp][:day],
        "conditions":  forecast[:daily].last[:weather].first[:description]
      }
    end
  end

end
