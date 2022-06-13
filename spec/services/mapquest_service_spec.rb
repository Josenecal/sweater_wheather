require 'rails_helper'

RSpec.describe 'mapquest service' do

  it "returns a hash with [:results][:locations][:latLng] containing a latitude and longitude" do
    mocked_response = File.read('spec/fixtures/geocode_address_denver.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=pRuCoWHchSOKGuwWLh3i6d8n0MtY2iKa&location=Denver,CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v2.3.0'
          }).
        to_return(status: 200, body: mocked_response, headers: {})

    response = MapquestService.geocode_address("Denver,CO")
    lat_lng = response[:results][0][:locations][0][:latLng]
    expect(lat_lng.class).to eq Hash
    expect(lat_lng[:lat].to_s).to match /\d+.\d+/
    expect(lat_lng[:lng].to_s).to match /\d+.\d+/
  end

end
