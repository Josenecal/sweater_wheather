require 'rails_helper'

RSpec.describe "Retrieve weather for a city endpoint: " do

  context "Requires the correct headers" do

    it "requires request header to contain Content-Type: application/json", :vcr do
      get "/api/v1/forecast?location=denver,co"
      expect(response).to be successful
    end

    it "requires request header to contain Accept: application/json", :vcr do

    end

  end

  context "Responds with the correct JSON shape: ", :vcr do

  end

  context "Edge Cases and Unexpected Use Cases: ", :vcr do

  end

end
