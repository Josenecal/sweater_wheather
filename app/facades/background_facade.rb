class BackgroundsFacade

  def get_backgrounds(location)
    json_response = UnsplashService.search_photos(location)
    Background.new(json_response[:results].first)
  end

end
