require 'rails_helper'

RSpec.describe Api::V1::BackgroundSerializer do

  it 'accepts a Background object as an argument and serializes an acceptable json response shape' do
    unsplash_response = File.read("spec/fixtures/unsplash_response_denver_landscape.json")
    parsed = JSON.parse(unsplash_response, symbolize_names: true)
    background_instance = Background.new(parsed[:results].first)
    response = Api::V1::BackgroundSerializer.background_response(background_instance, "Denver,CO")
    expect(response.keys.length).to eq 1
    expect(response[:data].class).to eq Hash
    expect(response[:data].keys.length).to eq 3
    expect(response[:data][:id]).to eq nil
    expect(response[:data][:type]).to eq "image"
    expect(response[:data][:attributes].class).to eq Hash
    expect(response[:data][:attributes].keys.length).to eq 1
    expect(response[:data][:attributes][:image].class).to eq Hash
    expect(response[:data][:attributes][:image][:location]).to eq "Denver,CO"
    expect(response[:data][:attributes][:image][:credit].class).to eq Hash
    expect(response[:data][:attributes][:image][:credit].keys.length).to eq 4
    expect(response[:data][:attributes][:image][:credit][:source].class).to eq String
    expect(response[:data][:attributes][:image][:credit][:author].class).to eq Array
    expect(response[:data][:attributes][:image][:credit][:author_link].class).to eq String
    expect(response[:data][:attributes][:image][:credit][:logo].class).to eq String
  end
end
