class OpenWeatherMapService

  def self.openweather_conn
    connection = Faraday.new(:get "https://api.openweathermap.org", params: {appid: ENV['openweather_api_key']})
  end

  def self.get_forcast(lat,lng)
    response = openweather_conn.get("")
    parsed = JSON.parse(response.body)
end
