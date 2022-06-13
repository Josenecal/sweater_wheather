class UnsplashService

  def self.conn
    connection = Faraday.new(url: "https://api.unsplash.com", params: {client_id: ENV['unsplash_api_key']})
  end

  def self.search_photos(location)
    response = conn.get("/search/photos", {query: location})
    JSON.parse(response.body, symbolize_names: true)
  end

end
