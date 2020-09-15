class Api

    @@page = 0
    
  def self.get_deals
    uri = URI.parse(Api.url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body).each{ |deal| Deal.new(deal) }
  end

  def self.url
    @@url = "https://www.cheapshark.com/api/1.0/deals?pageNumber=#{self.page}"
  end

  def self.add_page
    @@page += 1
  end

  def self.subtract_page
    @@page -= 1
  end

  def self.page
    @@page
  end
end