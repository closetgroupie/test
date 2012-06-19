class Legacy::Category < Legacy::Base
  set_table_name  'item_categories'
  set_primary_key 'id'

  def segments
    @segments ||= ::Segment.pluck(:legacy_id)
  end

  def to_model
    if self.parent_id.present?
      if self.segments.include?(self.parent_id)
        segment_id = Segment.find_by_legacy_id(self.parent_id).id
      else
        category = Category.find_by_legacy_id(self.parent_id)
        segment_id = category.segment_id
      end

      ::Category.new do |c|
        c.segment_id = segment_id
        c.legacy_id  = self.id
        c.name       = self.name
        c.parent_id  = category.id if category.present?
        c.slug       = self.name.parameterize
        c.order      = self.display_order
      end
    end
  end
end
