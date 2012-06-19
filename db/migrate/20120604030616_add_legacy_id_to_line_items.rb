class AddLegacyIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :legacy_id, :integer
  end
end
