class ApplicationController < ActionController::API

  def check_header
    if request.headers["Content-Type"] != "application/json" || request.headers["Accept"] != "application/json"
      render json: { "error": "request header should specify {'Content-Type' => 'application/json', 'Accept' => 'application.json'}" }, status: 406
    end
  end

  def check_body
    request_body = JSON.parse(request.body.read, symbolize_names: true)
    unless User.exists? api_key: request_body[:api_key]
      render json: { "error": "unauthorized" }, status: 401
    end
    if request_body[:origin] == nil || request_body[:destination] == nil
      render json: { "error": "origin or destination left empty" }, status: 400
    elsif request_body[:origin].empty? || request_body[:destination].empty?
      render json: { "error": "origin or destination keys missing from request body" }, status: 400
    end
  end

end
