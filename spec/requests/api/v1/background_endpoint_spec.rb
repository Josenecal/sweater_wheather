require 'rails_helper'

RSpec.describe 'background endpoint' do

  it 'returns a single image result with atributes' do
    mocked_response = File.read("spec/fixtures/unsplash_response_denver_landscape.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=SAcJ_Tz0EOINh6WXFh3NL8Iobqy8ZHLjYPJ3S1qa-Ww&query=Denver,CO").
    with( headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.3.0'
       }).
    to_return(status: 200, body: mocked_response, headers: {})

    get "/api/v1/backgrounds?location=Denver,CO"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body.class).to eq Hash
    expect(response_body.keys.
  end

end
