class Api::V1::RoadTripController < ApplicationController

  before_action :check_header, :check_body

  def create
    trip_obj = RoadTripFacade.get_roadtrip(roadtrip_params)
    render json: Api::V1::RoadTripSerializer.response(trip_obj), status: 200
  end

  private

  def roadtrip_params
    request_body = JSON.parse(request.body.read, symbolize_names: true)
    return {
      start_city: request_body[:origin],
      end_city: request_body[:destination],
      travel_time: nil,
      weather_at_eta: nil
    }
  end

end
