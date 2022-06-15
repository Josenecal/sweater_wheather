require 'rails_helper'

RSpec.describe Forecast do

  it "instantiates from a JSON object with appropriately nested values" do
    json = JSON.parse(File.read("spec/fixtures/open_weather_api_denver.json"), symbolize_names: true)
    instance = Forecast.new(json)
    expect(instance.class).to be Forecast
  end
end
