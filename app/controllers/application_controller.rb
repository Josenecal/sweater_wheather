class ApplicationController < ActionController::API

  def check_header
    if request.headers["Content-Type"] != "application/json" || request.headers["Accept"] != "application/json"
      render json: { "error": "request header should specify {'Content-Type' => 'application/json', 'Accept' => 'application.json'}" }, status: 406
    end
  end

  def check_api_key
    key = JSON.parse(request.body.read, symbolize_names: true)[:api_key]
    unless User.exists? api_key: key
      render json: { "error": "unauthorized" }, status: 401
    end
  end

end
