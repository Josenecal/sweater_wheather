class Api::V1::ForecastsController < ApplicationController

  before_action :check_header

  def show
    forecast_obj = ForecastFacade.get_forecast_from_location(params[:location])
    render json: Api::V1::ForecastSerializer.response(forecast_obj), status: 200
  end

end
