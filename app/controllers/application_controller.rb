class ApplicationController < ActionController::API

  def check_header
    if request.headers["Content-Type"] != "application/json" || request.headers["Accept"] != "application/json"
      render json: { "error": "request header should specify {'Content-Type' => 'application/json', 'Accept' => 'application.json'}" }, status: 406
    end
  end
end
