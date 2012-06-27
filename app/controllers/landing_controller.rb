class LandingController < ApplicationController
  def index
    @items_by_segment = {
      "Womens" => [751, 747, 637, 161],
      "Girls"  => [620, 376, 375, 540],
      "Boys"   => [550, 392, 429, 364],
      "Babies" => [433, 98, 15, 331]
    }

    # Boys: White pants, Blue Shirt, Pants, green shirt
    # Womens: Print dress, Shirt, Dress, Shoes
    # Girls: Outfit, Shirt, Skirt, Shoes
    # Babies: dress, purple thing, Lion thing, Romper

    @items_by_segment.each do |segment, item_ids|
      @items_by_segment[segment] = Item.includes(:hero_image, :size, :segment).unscoped.where(id: item_ids)
    end

    # TODO: Use this instead once we have consolidated baby girls + baby boys in to one
    # @items_by_segment = Item.includes(:hero_image, :size, :segment).where(id: [womens, girls, boys, babies].flatten).group_by(&:segment)
  end
end
