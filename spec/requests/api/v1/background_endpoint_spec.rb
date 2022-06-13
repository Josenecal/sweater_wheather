require 'rails_helper'

RSpec.describe 'background endpoint' do

  context "Requires the correct headers" do

    it "requires request header to contain Content-Type: application/json" do
      get "/api/v1/backgrounds?location=Denver,CO", headers: { "Accept" => "application/json" }
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/backgrounds?location=Denver,CO", headers: { "Content-Type" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
      get "/api/v1/backgrounds?location=Denver,CO"
      expect(response.status.to_s).to match /4\d\d/
    end

    it "requires a city and state parameter" do
      get "/api/v1/backgrounds", headers: { "Content-Type" => "application/json", "Accept" => "application/json"}
      expect(response.status.to_s).to match /4\d\d/
    end

  end

  it 'returns a single image result with atributes' do
    # Mock external API response to avoid rate limits
    mocked_response = File.read("spec/fixtures/unsplash_response_denver_landscape.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=SAcJ_Tz0EOINh6WXFh3NL8Iobqy8ZHLjYPJ3S1qa-Ww&query=Denver,CO").
    with( headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.3.0'
       }).
    to_return(status: 200, body: mocked_response, headers: {})

    # Get endpoint
    get "/api/v1/backgrounds?location=Denver,CO", headers: { "Content-Type" => "application/json", "Accept" => "application/json"}
    response_body = JSON.parse(response.body, symbolize_names: true)

    # Assertions: key nesting and values
    expect(response_body.class).to eq Hash
    expect(response_body.keys).to eq [:data]
    expect(response_body[:data].keys).to eq [:type, :id, :attributes]
    expect(response_body[:data].keys.length).to eq 3
    expect(response_body[:data][:type]).to eq "image"
    expect(response_body[:data][:id]).to eq "null"
    expect(response_body[:data][:attributes].class).to eq Hash
    expect(response_body[:data][:attributes].keys).to eq [:image]
    expect(response_body[:data][:attributes][:image].keys).to eq [:location, :image_url, :credit]
    # Regex only matches the pattern "[start][any letters],[two letters][end]"
    expect(response_body[:data][:attributes][:image][:location]).to match /\A[a-zA-Z]+,[a-zA-Z][a-zA-Z]\Z/
    expect(response_body[:data][:attributes][:image][:image_url]).to match /\Ahttps:\/\/images.unsplash.com\/photo-/
    expect(response_body[:data][:attributes][:image][:credit].class).to be Hash
    expect(response_body[:data][:attributes][:image][:credit].keys).to eq [:source, :author, :author_link, :logo]
    expect(response_body[:data][:attributes][:image][:credit].keys.length).to eq 4
    expect(response_body[:data][:attributes][:image][:credit][:source]).to eq "unsplash.com"
    expect(response_body[:data][:attributes][:image][:credit][:author].class).to eq Array
    expect(response_body[:data][:attributes][:image][:credit][:author].first.class).to be String
    expect(response_body[:data][:attributes][:image][:credit][:author].last.class).to be String
    expect(response_body[:data][:attributes][:image][:credit][:author_link].class).to eq String
    expect(response_body[:data][:attributes][:image][:credit][:author_link]).to match /\Ahttps:\/\/api.unsplash.com\/users\//
    expect(response_body[:data][:attributes][:image][:credit][:logo]).to eq "https://pixabay.com/static/img/logo_square.png"
  end

end
