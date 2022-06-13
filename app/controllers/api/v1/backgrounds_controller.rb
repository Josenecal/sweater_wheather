class Api::V1::BackgroundsController < ApplicationController

  before_action :check_header

  def show
    if params[:location] !~ /\A[A-Za-z]+,[A-Za-z][A-Za-z]\Z/
      render json: { "error": "location parameter is required" }, status: 400
    else
      background = BackgroundsFacade.get_backgrounds(params[:location])
      render json: Api::V1::BackgroundSerializer.background_response(background, params[:location])
    end
  end

end
