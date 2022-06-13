class Api::V1::BookSearchController < ApplicationController

  def index
    books_objs_array = BooksFacade.get_about_destination(params[:location], params[:quantity])
    forecast_obj = ForecastFacade.get_forecast_from_location(params[:location])
    render json: Api::V1::BookSearchSerializer.response(params[:location], forecast_obj, books_objs_array), status: 200
  end

end
