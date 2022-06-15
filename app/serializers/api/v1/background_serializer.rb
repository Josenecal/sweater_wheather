class Api::V1::BackgroundSerializer

  def self.background_response (background_obj, location)
    {
  "data": {
    "type": "image",
    "id": nil,
    "attributes": {
      "image": {
        "location": location,
        "image_url": background_obj.picture_link,
        "credit": {
          "source": "unsplash.com",
          "author": background_obj.author_name,
          "author_link": background_obj.author_link,
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}
  end

end
