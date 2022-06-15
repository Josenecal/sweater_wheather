class RoadTripController < ApplicationController

  before_action :check_headers, :check_api_key

  def create
    trip = RoadTripFacade.get_roadtrip(roadtrip_params)
  end

  private

  def roadtrip_params
    parameters = JSON.parse(request.body)
    return {
      start_city: parameters[:start_city],
      end_city: parameters[:end_city],
      travel_time: nil,
      weather_at_eta: nil
    }
  end

end
