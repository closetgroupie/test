module Api
  module Entities
    class ListItem < Grape::Entity
      expose( :brand ) do | item , options |
        item.brand.presence ||
        item.brand_suggestion.presence ||
        "N/A"
      end
      expose :id
      expose( :image_url ) do | item , options |
        base = Closetgroupie::Application.config.base_url
        "#{base}#{ item.hero_image.image_url }"
      end
      expose :price
      expose( :size ) { | item , options | item.size.to_s }
      expose :sold
      expose :title
    end
  end
end
