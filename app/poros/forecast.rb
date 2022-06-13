class Forecast

  attr_reader :current_weather, :hourly_weather, :daily_weather

  def initialize(forecast)
    @current_weather = format_current_weather(forecast[:current])
    @hourly_weather = format_hourly_weather(forecast[:hourly])
    @daily_weather = format_daily_weather(forecast[:daily])

  end

  def format_daily_weather(daily_array)
    daily_array.first(5).map do |day|
      {
        date: format_date_time(day[:dt], "date"),
        sunrise: format_date_time(day[:sunrise], "date_time"),
        sunset: format_date_time(day[:sunset], "date_time"),
        max_temp: convert_kelvin(day[:temp][:max]),
        min_temp: convert_kelvin(day[:temp][:min])
      }
    end
  end

  def format_hourly_weather(hourly_array)
    hourly_array.first(5).map do |hour|
      {
        time: format_date_time(hour[:dt], "time"),
        temperature: convert_kelvin(hour[:temp]),
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end
  end

  def format_current_weather(current_forecast)
    {
      datetime: format_date_time(current_forecast[:dt], "date_time"),
      sunrise: format_date_time(current_forecast[:sunrise], "date_time"),
      sunset: format_date_time(current_forecast[:sunset], "date_time"),
      temp: convert_kelvin(current_forecast[:temp]),
      feels_like: convert_kelvin(current_forecast[:feels_like]),
      humidity: current_forecast[:humidity],
      uvi: current_forecast[:uvi],
      visibility: current_forecast[:visibility],
      conditions: current_forecast[:weather].first[:descripion],
      icon: current_forecast[:weather].first[:icon]
    }
  end

  def convert_kelvin(temp)
    "#{1.8*(temp-273.15)+32} F"
  end

  def format_date_time (utc_time, output)
    return Time.at(utc_time).utc.to_datetime if output == "date_time"
    return Time.at(utc_time).utc.to_time if output == "time"
    return Time.at(utc_time).utc.to_date if output == "date"
  end
end
