class BooksFacade

  def get_about_destination(location, quantity)
    json_response = OpenLibraryService.search_endpoint(separate_location(location), quantity)
    
  end

  def separate_location(combined)
    combined.sub(/,/, "+")
  end
end
