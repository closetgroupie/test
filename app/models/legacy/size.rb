class Legacy::Size < Legacy::Base
  set_table_name 'item_sizes'

  def to_model
    size_group_id = ::SizeGroup.find(self.item_size_group_id).id
    ::Size.new do |s|
      s.legacy_id = self.id
      s.name = self.name
      s.size_group_id = size_group_id
      s.order = self.display_order
    end
  end
end
