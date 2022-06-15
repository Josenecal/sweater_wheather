require 'rails_helper'

RSpec.describe Api::V1::NewUserSerializer do
  user = build(:user)
  response = Api::V1::NewUserSerializer.success(user)
  expect(response.keys).to eq [:data]
  expect(response[:data].keys).to eq [:type, :id, :attributes]
  expect(response[:type]).to eq "users"
  expect(response[:id].class).to eq Integer
  expect(response[:attributes].keys).to eq [:email, :api_key]
end
