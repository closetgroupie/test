class LandingController < ApplicationController
  def index
    @items_by_segment = {
      "Womens" => [751, 747, 637, 161],
      "Girls"  => [620, 376, 375, 540],
      "Boys"   => [392, 429, 364, 550],
      "Babies" => [433, 98, 15, 331]
    }

    @items_by_segment.each do |segment, item_ids|
      @items_by_segment[segment] = Item.includes(:hero_image, :size, :segment).where(id: item_ids)
    end

    # TODO: Use this instead once we have consolidated baby girls + baby boys in to one
    # @items_by_segment = Item.includes(:hero_image, :size, :segment).where(id: [womens, girls, boys, babies].flatten).group_by(&:segment)
  end
end
