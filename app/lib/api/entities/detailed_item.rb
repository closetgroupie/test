module Api
  module Entities
    class DetailedItem < Grape::Entity
      CONDITIONS = ::Item::CONDITIONS.invert

      expose( :brand ) { | item , options | item.brand_name }
      expose( :condition ) { | item , options | CONDITIONS[item.condition] }
      expose :description
      expose :id
      expose( :image_url ) do | item , options |
        base = Closetgroupie::Application.config.base_url
        "#{base}#{ item.hero_image.image_url }"
      end
      expose :price
      expose :shipping_abroad
      expose :shipping_cost
      expose :shipping_cost_bundled
      expose :shipping_from
      expose( :size ) { | item , options | item.size.to_s }
      expose :sold
      expose :title
    end
  end
end
