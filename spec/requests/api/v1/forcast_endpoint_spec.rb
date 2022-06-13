require 'rails_helper'

RSpec.describe "Retrieve weather for a city endpoint: " do

  context "Requires the correct headers" do

    it "requires request header to contain Content-Type: application/json" do
      get "/api/v1/forecast", params: {location: "denver,co" }, headers: { "Accept" => "application/json" }
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/forecast", params: {location: "denver,co" }, headers: { "Content-Type" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/forecast", params: {location: "denver,co" }
      expect(response.status.to_s).to match /4\d\d/
    end

    it "requires a city and state parameter" do
      get "/api/v1/forecast", headers: { "Content-Type" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
    end

  end

  context "Responds with the correct JSON shape: " do

    it "contains the correct headers nested in the correct order" do
      mocked_mapquest_response = File.read('spec/fixtures/geocode_address_denver.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_api_key']}&location=denver,co").
       with(
         headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.3.0'
         }).
       to_return(status: 200, body: mocked_mapquest_response, headers: {})
      mocked_openweather_response = File.read 'spec/fixtures/open_weather_api_denver.json'
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['openweather_api_key']}&exclude=minutely,alerts&lat=39.738453&lon=-104.984853").
       with(
         headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.3.0'
         }).
       to_return(status: 200, body: mocked_openweather_response, headers: {})
      get "/api/v1/forecast", params: { location: "denver,co" }, headers: { "Accept" => "application/json", "Content-Type" => "application/json" }
      response_body = JSON.parse response.body, symbolize_names: true
      expect(response_body.keys).to eq [:data]
    end
  end

  context "Edge Cases and Unexpected Use Cases: " do


  end

end
