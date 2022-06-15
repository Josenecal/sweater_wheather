class RoadTripController < ApplicationController

  before_action :check_headers, :check_body

  def create
    request_body = JSON.parse(request.body.read)
    if request_body
    trip = RoadTripFacade.get_roadtrip(roadtrip_params)
  end

  private

  def roadtrip_params
    request_body = JSON.parse(request.body)
    return {
      start_city: request_body[:origin],
      end_city: request_body[:destination],
      travel_time: nil,
      weather_at_eta: nil
    }
  end

end
