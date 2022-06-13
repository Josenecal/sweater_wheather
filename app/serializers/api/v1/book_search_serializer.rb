class BookSearchSerializer

  def self.response(location, forecast, books_array)
    {
  "data": {
    "id": "null",
    "type": "books",
    "attributes": {
      "destination": location,
      "forecast": {
        "summary": forecast.current_weather[:conditions],
        "temperature": forecast.current_weather[:temp]
      },
      "total_books_found": books_array.length,
      "books": books_array.map do |book|
        {
          "isbn": book.isbn,
          "title": book.title,
          "publisher": book.publisher
        }
      end
    }
  }
}
  end

end
