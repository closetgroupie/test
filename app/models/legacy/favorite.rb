class Legacy::Favorite < Legacy::Base
  set_table_name 'favorite_items'
  
  def to_model
    user = ::User.find_by_legacy_id(self.user_id).id
    item = ::Item.find_by_legacy_id(self.item_id).id

    ::Favorite.new do |f|
      f.legacy_id = self.id
      f.user_id = user
      f.item_id = item
      f.created_at = convert_to_datetime(self.created)
      f.updated_at = convert_to_datetime(self.created)
    end
  end
end
