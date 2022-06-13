class UnsplashService

  def self.conn
    connection = Faraday.new(:get, url: "https://api.unsplash.com", params: {client_id: ENV['unsplash_api_key']})
  end

  def self.search_photos(location)
    conn.get("/search/photos", {query: location})
    JSON.parse(response.body)
  end

end
