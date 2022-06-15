class MapquestService

  def self.mapquest_conn
    connection = Faraday.new(url: "http://www.mapquestapi.com", params: { key: ENV['mapquest_api_key'] })
  end

  def self.get_directions(start_city, end_city)
    response = mapquest_conn.get("/directions/v2/route", { from: start_city, to: end_city })
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.geocode_address(location)
    response = mapquest_conn.get("/geocoding/v1/address", { location: location })
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

end
