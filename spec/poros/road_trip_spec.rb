require 'rails_helper'

RSpec.describe RoadTrip do

  it "requires a single hash argument to initialize" do
    road_trip = RoadTrip.new Hash.new
    expect(road_trip.instance_variables).to eq [:@start_city, :@end_city, :@travel_time, :@weather_at_eta]
  end

  it "assigns attributse from the same keys in the instantiation hash" do
    road_trip = RoadTrip.new({
      start_city: "Denver,CO",
      end_city: "Boulder,CO",
      travel_time: 46,
      weather_at_eta: "cold liquid sunshine!",
      extra_key: "extraneous value",
      way_too_much: 42 })
    expect(road_trip.instance_variables).to eq [:@start_city, :@end_city, :@travel_time, :@weather_at_eta]
      expect(road_trip.start_city).to eq "Denver,CO"
      expect(road_trip.end_city).to eq "Boulder,CO"
      expect(road_trip.travel_time).to eq 46
      expect(road_trip.weather_at_eta).to eq "cold liquid sunshine!"
  end

  it "ignores other values passed with other keys" do
    road_trip = RoadTrip.new({
      start_city: "Denver,CO",
      end_city: "Boulder,CO",
      travel_time: 46,
      weather_at_eta: "cold liquid sunshine!",
      extra_key: "extraneous value",
      way_too_much: 42 })
      expect(road_trip.instance_variables.length).to eq 4
      expect(road_trip.start_city).to eq "Denver,CO"
      expect(road_trip.end_city).to eq "Boulder,CO"
      expect(road_trip.travel_time).to eq 46
      expect(road_trip.weather_at_eta).to eq "cold liquid sunshine!"
  end
  it "has a method #pretty_travel_time that reformats travel time more readably, or leaves as 'impossible'" do
    road_trip1 = RoadTrip.new({
      start_city: "Denver,CO",
      end_city: "Boulder,CO",
      travel_time: 2777,
      weather_at_eta: "IT'S GONNA RAIN!",
      extra_key: "extraneous value",
      way_too_much: 42
      })
    expect(road_trip1.pretty_travel_time).to eq "0 hours, 46 minutes"

    road_trip2 = RoadTrip.new({
      start_city: "Denver,CO",
      end_city: "Boulder,CO",
      travel_time: "impossible",
      weather_at_eta: "IT'S GONNA RAIN!",
      extra_key: "extraneous value",
      way_too_much: 42
      })
    expect(road_trip2.pretty_travel_time).to eq "impossible"
  end

end
