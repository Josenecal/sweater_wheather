class Api::V1::ForecastsController < ApplicationController

  before_action :check_header

  def show
    render json: { "message": "under development" }
  end

end
