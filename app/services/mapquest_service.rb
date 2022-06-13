class MapquestService

  def self.mapquest
    connection = Faraday.new(url: "http://www.mapquestapi.com", params: { key: ENV['mapquest_api_key'] })
  end

  def self.geocode_address(location)
    response = mapquest.get("/geocoding/v1/address", { location: location })
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

end
