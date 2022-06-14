class Api::V1::NewUserSerializer

  def success(user)
    {
      "data": {
        "type": "users",
        "id": user.id,
        "attributes": {
          "email": user.email,
          "api_key": user.api_key
        }
      }
    }
  end

end
