class Legacy::Item < Legacy::Base
  set_table_name 'items'

  def to_model
    user = ::User.includes(:closet).find_by_legacy_id(self.user_id)
    category = ::Category.includes(:segment).find_by_legacy_id(self.item_category_id)
    size = ::Size.find_by_legacy_id(self.item_size_id)

    ::Item.new do |i|
      i.legacy_id = self.id
      i.user_id = user.id
      i.closet_id = user.closet.id
      i.title = self.title
      i.segment_id = category.segment_id
      i.category_id = category.id
      i.size_id = size.id if size.present?
      i.condition = self.item_condition_id
      i.brand_id = self.item_brand_id
      i.brand_suggestion = self.suggested_brand if self.suggested_brand.present?
      i.description = self.description
      i.price = self.price # real?
      i.shipping_cost = self.shipping_price
      i.shipping_cost_bundled = self.shipping_price_packaged
      i.shipping_from = "US"
      i.shipping_abroad = self.ship_international?
      i.shipping_notes = self.shipping_notes
      i.created_at = convert_to_datetime(self.created)
      i.updated_at = convert_to_datetime(self.updated)
      i.sold = self.sold
    end
  end
end
