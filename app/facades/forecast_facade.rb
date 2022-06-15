class ForecastFacade

  def self.get_forecast_from_location(location)
    forecast = get_forecast_json_from_location(location)
    response = Forecast.new(forecast)
  end

  def self.get_forecast_json_from_location(location)
    lat_lng_hash = location_to_coordinate(location)
    forecast = get_forecast_from_coordinate_hash(lat_lng_hash)
  end

  def self.get_forecast_from_coordinate_hash(input_hash)
    response = OpenWeatherMapService.get_forecast(input_hash[:lat], input_hash[:lng])
  end

  def self.location_to_coordinate(location)
    geo_hash = MapquestService.geocode_address(location)
    lat_lng_hash = geo_hash[:results][0][:locations][0][:latLng]
  end
end
