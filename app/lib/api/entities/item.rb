module Api
  module Entities
    class Item < Grape::Entity
      expose :brand
      expose :condition
      expose :description
      expose :id
      expose( :image_url ){ | item , options | item.hero_image.image_url }
      expose :price
      expose :shipping_abroad
      expose :shipping_cost
      expose :shipping_cost_bundled
      expose :shipping_from
      expose :size
      expose :sold
      expose :title
    end
  end
end
