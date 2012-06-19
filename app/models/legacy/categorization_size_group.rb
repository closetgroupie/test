class Legacy::CategorizationSizeGroup < Legacy::Base
  set_table_name 'item_category_size_groups'
  
  def segments
    @segments ||= ::Segment.pluck(:legacy_id)
  end

  def to_model
    if segments.include?(self.item_category_id)
      segment_id = Segment.find_by_legacy_id(self.item_category_id).id
    else
      category = ::Category.find_by_legacy_id(self.item_category_id)
      segment_id = category.segment_id unless category.nil?
      category_id = category.id unless category.nil?
    end

    if segment_id.present?
      ::CategorizationSizeGroup.new do |csg|
        csg.legacy_id = self.id
        csg.segment_id = segment_id
        csg.category_id = category_id if category_id.present?
        csg.size_group_id = self.item_size_group_id
        csg.order = self.display_order
      end
    end
  end
end
