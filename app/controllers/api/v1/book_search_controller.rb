class Api::V1::BookSearchController < ApplicationController

  def index
    books_objs_array = BooksFacade.get_about_destination(params[:location], params[:quantity])
    forecast_obj = ForecstFacade.get_forecast_from_location(params[:location])
    render json: Api::V1::BooksSerializer.response(forecast_obj, books_objs_array, params[:location]), status: 200
  end

end
