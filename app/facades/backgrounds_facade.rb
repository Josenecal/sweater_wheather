class BackgroundsFacade

  def self.get_backgrounds(location)
    json_response = UnsplashService.search_photos(location)
    Background.new(json_response[:results].first)
  end

end
