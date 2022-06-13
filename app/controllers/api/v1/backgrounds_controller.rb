class Api::V1::BackgroundsController < ApplicationController

  def show
    background = BackgroundsFacade.get_backgrounds(params[:location])
    render json: Api::V1::BackgroundSerializer.background_response(background, params[:location])
  end

end
