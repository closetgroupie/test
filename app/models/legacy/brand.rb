class Legacy::Brand < Legacy::Base
  set_table_name 'item_brands'

  def to_model
    unless self.item_category_id.zero?
      segment = ::Segment.find_by_legacy_id(self.item_category_id)
      ::Brand.new do |b|
        b.legacy_id  = self.id
        b.segment_id = segment.id
        b.name       = self.name
        b.slug       = self.name.parameterize
      end
    end
  end
end
