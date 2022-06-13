class Background
  attr_reader :author_link, :author_name, :picture_link

  def initialize(response_json)
    @author_name = response_json[:user][:name],
    @author_link = response_json[:user][:links][:self],
    @picture_link = response_json[:urls][:full]
  end
end
