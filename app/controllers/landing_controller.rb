class LandingController < ApplicationController
  def index
    womens = [751, 747, 637, 161]
    girls  = [620, 376, 375, 540]
    boys   = [392, 429, 364, 550]
    babies = [433, 98, 15, 331]
    @items_by_segment = Item.includes(:hero_image, :size, :segment).where(id: [womens, girls, boys, babies].flatten).group_by(&:segment)
end
