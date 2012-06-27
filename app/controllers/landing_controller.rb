class LandingController < ApplicationController
  def index
    ids_by_segment = {
      "Womens" => [637, 751, 747, 161],
      "Girls"  => [620, 375, 376, 540],
      "Boys"   => [550, 392, 429, 364],
      "Babies" => [433, 98, 331, 15]
    }

    items = Item.unscoped.includes(:hero_image, :size).find(ids_by_segment.values.flatten).index_by(&:id)
    @items_by_segment = {}

    ids_by_segment.each do |segment, ids|
      @items_by_segment[segment] = []

      ids.each do |id|
        @items_by_segment[segment] << items[id]
      end

    end

    # TODO: Use this instead once we have consolidated baby girls + baby boys in to one
    # @items_by_segment = Item.includes(:hero_image, :size, :segment).where(id: [womens, girls, boys, babies].flatten).group_by(&:segment)
  end
end
