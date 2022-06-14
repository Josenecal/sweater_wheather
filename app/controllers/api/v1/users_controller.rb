class Api::V1::UsersController < ApplicationController

  before_action :check_header

  def create
    if user_creation_params[:password] != user_creation_params[:password_confirmation]
      render json: { "error": "password and password_confirmation do not match" }, status: 400
    else
      user = User.create(user_creation_params)

      render json: Api::V1::NewUserSerializer.success(user), status: 201
    end
  end

  private

  def user_creation_params
    json = JSON.parse(request.body.read)
    new_key = SecureRandom.hex
    # Given the odds of a duplicate SecureRandom hex... I feel okay about this
    while User.exists?(api_key: new_key) { new_key = SecureRandom.hex }
    { email: json['email'], password: json['password'], password_confirmation: json[:password_confirmation], api_key: new_key }
  end

end
