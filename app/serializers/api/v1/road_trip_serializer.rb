class Api::V1::RoadTripSerializer

  def self.response(roadtrip)
    {
  "data": {
    "id": nil,
    "type": "roadtrip",
    "attributes": {
      "start_city": roadtrip.start_city,
      "end_city": roadtrip.end_city,
      "travel_time": roadtrip.pretty_travel_time,
      "weather_at_eta": roadtrip.weather_at_eta
    }
  }
}
  end

end
