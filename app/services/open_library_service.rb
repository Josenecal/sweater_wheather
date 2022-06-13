class OpenLibraryService

  def self.conn
    Faraday.new(url: "https://openlibrary.org")
  end

  def self.search_endpoint(query, quantity)
    response = conn.get('/search.json', { q: query, limit: quantity })
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
