class GetDeals

    @@page = 0
    
  def self.get_deals
    uri = URI.parse(GetDeals.url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def self.parse
    hash = JSON.parse(self.get_deals).collect do |deal|
        deal.transform_keys(&:to_sym)
    end
    hash
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