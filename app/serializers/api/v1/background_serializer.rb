class Api::V1::BackgroundSerializer

  def self.background_response (background_obj, location)
    {
  "data": {
    "type": "image",
    "id": "null",
    "attributes": {
      "image": {
        "location": location,
        "image_url": background_obj.picture_link,
        "credit": {
          "source": "unsplash.com",
          "author": background_obj.author_name,
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}
  end

end
