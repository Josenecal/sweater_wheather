require 'rails_helper'

RSpec.describe Api::V1::ForecastSerializer do
  it 'accepts and serializes a forecast object with array and hash attributes' do
    json_response = File.read("spec/fixtures/open_weather_api_denver.json")
    forecast = Forecast.new(JSON.parse(json_response, symbolize_names: true))
    response = Api::V1::ForecastSerializer.response(forecast)
    expect(response.keys).to eq [:data]
    expect(response[:data].keys.length).to eq 3
      expect(response[:data][:id]).to eq nil
      expect(response[:data][:type]).to eq "forecast"
      expect(response[:data][:attributes].class).to eq Hash
        expect(response[:data][:attributes].keys.length).to eq 3
        expect(response[:data][:attributes][:current_weather].class).to eq Hash
        expect(response[:data][:attributes][:daily_weather].class).to eq Array
        expect(response[:data][:attributes][:hourly_weather].class).to eq Array
          expect(response[:data][:attributes][:current_weather].keys.count).to eq 10
          expect(response[:data][:attributes][:current_weather][:datetime].class).to eq DateTime
          expect(response[:data][:attributes][:current_weather][:temperature]).to match /\A\-{0,1}\d+\WF\Z/
          expect(response[:data][:attributes][:current_weather][:sunrise].class).to eq DateTime
          expect(response[:data][:attributes][:current_weather][:sunset].class).to eq DateTime
          expect(response[:data][:attributes][:current_weather][:feels_like]).to match /\A\-{0,1}\d+\WF\Z/
          expect(response[:data][:attributes][:current_weather][:humidity].class).to eq Integer
          expect(response[:data][:attributes][:current_weather][:uvi].class).to eq Integer
          expect(response[:data][:attributes][:current_weather][:visibility].class).to eq Integer
          expect(response[:data][:attributes][:current_weather][:conditions].class).to eq String
          expect(response[:data][:attributes][:current_weather][:icon].class).to eq String
          expect(response[:data][:attributes][:daily_weather].length).to eq 5 # normally 48, shortened for mocked response
          response[:data][:attributes][:daily_weather].each do |day_hash|
            expect(day_hash.keys.length).to eq 5
            expect(day_hash[:date].class).to eq Date
            expect(day_hash[:sunrise].class).to eq DateTime
            expect(day_hash[:sunset].class).to eq DateTime
            expect(day_hash[:min_temp]).to match /\A\-{0,1}\d+\WF\Z/
            expect(day_hash[:max_temp]).to match /\A\-{0,1}\d+\WF\Z/
          end
          expect(response[:data][:attributes][:hourly_weather].length).to eq 5 # normally 7, shortened for mocked response
          response[:data][:attributes][:hourly_weather].each do |hour_hash|
            expect(hour_hash.keys.length).to eq 4
            expect(hour_hash[:time].class).to eq Time
            expect(hour_hash[:conditions].class).to eq String
            expect(hour_hash[:icon].class).to eq String
            expect(hour_hash[:temperature]).to match /\A\-{0,1}\d+\WF\Z/
          end
  end
end
