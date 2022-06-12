require 'rails_helper'

RSpec.describe "Retrieve weather for a city endpoint: " do

  it "is currently responsive" do
    get "/api/v1/forecast?location=denver,co", params: { location: "denver,co" }, headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
    expect(response.status.to_s).to match /2\d\d/
  end

  context "Requires the correct headers" do

    it "requires request header to contain Content-Type: application/json", :vcr do
      get "/api/v1/forecast", params: {location: "denver,co" }, headers: { "Accept" => "application/json" }
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/forecast", params: {location: "denver,co" }, headers: { "Content-Type" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/forecast", params: {location: "denver,co" }
      expect(response.status.to_s).to match /4\d\d/
    end

    it "requires a city and state parameter", :vcr do
      get "/api/v1/forecast", headers: { "Content-Type" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
    end

  end

  context "Responds with the correct JSON shape: ", :vcr do

    it "contains the correct headers nested in the correct order" do
      get "/api/v1/forecast", params: { location: "denver,co" }, headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      response_body = JSON.parse response.body, symbolize_names: true
      expect(response_body.keys).to eq [:data]
    end
  end

  context "Edge Cases and Unexpected Use Cases: ", :vcr do

  end

end
