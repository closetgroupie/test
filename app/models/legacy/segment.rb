class Legacy::Segment < Legacy::Base
  set_table_name  'item_categories'
  set_primary_key 'id'

  def to_model
    ::Segment.new do |s|
      s.legacy_id = self.id
      s.name      = self.name
      s.slug      = self.name.parameterize
    end unless self.parent_id.present?
  end
end
