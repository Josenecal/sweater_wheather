class OpenWeatherMapService

  def self.openweather_conn
    connection = Faraday.new(url: "https://api.openweathermap.org", params: {appid: ENV['openweather_api_key']})
  end

  def self.get_forecast(lat,lng)
    response = openweather_conn.get("/data/2.5/onecall", {lat: lat, lon: lng, exclude: "minutely,alerts"})
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
