class RoadTrip

  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(road_trip_hash)
    @start_city = road_trip_hash[:start_city]
    @end_city = road_trip_hash[:end_city]
    @travel_time = road_trip_hash[:travel_time]
    @weather_at_eta = road_trip_hash[:weather_at_eta]
  end

  def pretty_travel_time
    if @travel_time == "impossible"
     return "impossible"
   else
     hours = @travel_time.to_i / 3600
     minutes = (@travel_time.to_i % 3600) / 60
     return "#{hours} hours, #{minutes} minutes"
   end
 end

end
