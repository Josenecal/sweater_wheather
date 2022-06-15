class Api::V1::UsersController < ApplicationController

  before_action :check_header

  def create
    user_hash ||= user_creation_params
    if user_creation_params[:password] != user_hash[:password_confirmation]
      render json: { "error": "password and password_confirmation do not match" }, status: 400
    elsif user_hash[:password] == nil || user_hash[:password_confirmation] == nil
      render json: { "error": "password and password_confirmation are required" }, status: 400
    elsif user_hash[:password].empty? || user_hash[:password_confirmation].empty?
      render json: { "error": "password and password_confirmation cannot be empty" }, status: 400
    elsif User.exists?(email: user_hash[:email])
      render json: { "error": "user account with this email already exists"}, status: 400
    elsif user_hash[:email] == nil
      render json: { "error": "bad email" }, status: 400
    else
      User.create(user_hash)
      user = User.find_by(email: user_hash[:email])
      render json: Api::V1::NewUserSerializer.success(user), status: 201
    end
  end

  def validate
    if !User.exists?(email: user_validation_params[:email])
      render json: { "error": "validation failed" }, status: 400
    else
      user = User.find_by(email: user_validation_params[:email])
      if user.authenticate(params[:password])
        render json: Api::V1::NewUserSerializer.success(user), status: 200
      else
        render json: { "error": "validation failed" }, status: 400
      end
    end
  end

  private

  def user_validation_params
    request.body.read.empty? ? json = {} : json = JSON.parse(request.body.read)
    { email: validated_email, password: json['password'] }
  end

  def user_creation_params
    request.body.read.empty? ? json = {} : json = JSON.parse(request.body.read)
    new_key = SecureRandom.hex
    while User.exists?(api_key: new_key)
      new_key = SecureRandom.hex
    end
    { email: validated_email, password: json['password'], password_confirmation: json['password_confirmation'], api_key: new_key }
  end

  def validated_email
    request.body.read.empty? ? email = nil : email = JSON.parse(request.body.read, symbolize_names: true)[:email]
    if email =~ /\A[\w\~\.\-\_]+\@[\w\~\.\-\_]+[\.[a-z]+]{1,2}\Z/
      return email.downcase
    else
      return nil
    end
  end


end
