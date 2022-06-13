require 'rails_helper'

RSpec.describe 'response profiles for books-search endpoint' do

  it "responds with the expected profile for a good request" do
    mocked_books_response = File.read("spec/fixtures/open_library_response_denver_co.json")
    # stub open library request/response

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
    get '/api/v1/book-search?location=denver,co&quantity=5'
    response_body = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(response_body.class).to eq Hash
    # assert has correct attributes
  end

end
