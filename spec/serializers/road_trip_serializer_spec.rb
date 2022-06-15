require 'rails_helper'

RSpec.describe Api::V1::RoadTripSerializer do

  it "accepts a RoadTrip instance and generates the perscribed roadtrip JSON response shape" do
    roadtrip = RoadTrip.new({start_city: "Tacoma,WA", end_city: "Boise,ID", travel_time: 31536000, weather_at_eta: {temperature: 401.5, conditions: "fire and brimstone"}})
    response = Api::V1::RoadTripSerializer.response(roadtrip)
    expect(response.keys).to eq [:data]
    expect(response[:data][:id]).to eq nil
    expect(response[:data][:type]).to eq "roadtrip"
    expect(response[:data][:attributes].class).to eq Hash
    expect(response[:data].keys.length).to eq 3
    expect(response[:data][:attributes][:start_city]).to eq roadtrip.start_city
    expect(response[:data][:attributes][:end_city]).to eq roadtrip.end_city
    expect(response[:data][:attributes][:travel_time]).to eq "8760 hours, 0 minutes"
    expect(response[:data][:attributes][:weather_at_eta]).to eq roadtrip.weather_at_eta
 end

end
