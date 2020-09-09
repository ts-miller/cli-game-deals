class Deal
    attr_accessor :internalName, :title, :dealID, :salePrice, :thumb,
    :normalPrice, :savings, :storeID, :steamRatingText, :releaseDate,
    :steamRatingPercent, :steamAppID, :dealRating, :steamRatingCount,
    :metacriticLink, :gameID, :isOnSale, :metacriticScore, :lastChange

    @@all = []
    
    def initialize(deal)
        deal.each {|key, value| self.send(("#{key}="), value) }
        @@all << self
    end

    def self.all
        @@all
    end
end