class Api::V1::ForecastSerializer

  def self.response(forecast)
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": forecast.current_weather[:datetime],
            "temperature": forecast.current_weather[:temp],
            "sunrise": forecast.current_weather[:sunrise],
            "sunset": forecast.current_weather[:sunset],
            "feels_like": forecast.current_weather[:feels_like],
            "humidity": forecast.current_weather[:humidity],
            "uvi": forecast.current_weather[:uvi],
            "visibility": forecast.current_weather[:visibility],
            "conditions": forecast.current_weather[:conditions],
            "icon": forecast.current_weather[:icon]
          },
          "daily_weather": forecast.daily_weather,
          "hourly_weather": forecast.hourly_weather
        }
      }
    }
  end

end
