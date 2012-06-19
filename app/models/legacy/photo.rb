class Legacy::Photo < Legacy::Base
  set_table_name 'item_images'

  def to_model
    item = ::Item.find_by_legacy_id(self.item_id)

    if item.present?
      ::Photo.new do |p|
        p.legacy_id = self.id
        p.item_id = item.id
        p.image = self.large_img
        p.order = self.display_order
        p.created_at = convert_to_datetime(self.created)
        p.updated_at = convert_to_datetime(self.created)
      end
    end
  end
end
