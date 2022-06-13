require 'rails_helper'

RSpec.describe 'background endpoint' do

  it 'returns a single image result with atributes' do
    get "/api/v1/backgrounds?location=Denver,CO"
    binding.pry
  end

end
