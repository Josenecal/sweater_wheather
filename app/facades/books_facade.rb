class BooksFacade

  def self.get_about_destination(location, quantity)
    json_response = OpenLibraryService.search_endpoint(separate_location(location), quantity)
    books_array = json_response[:docs].map do |book_hash|
      Book.new(book_hash)
    end
  end

  def self.separate_location(combined)
    combined.sub(/,/, "+")
  end
end
