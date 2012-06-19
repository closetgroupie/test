class Legacy::SizeGroup < Legacy::Base
  set_table_name 'item_size_groups'

  def to_model
    ::SizeGroup.new do |sg|
      sg.id = self.id
      sg.name = self.name
    end
  end
end
