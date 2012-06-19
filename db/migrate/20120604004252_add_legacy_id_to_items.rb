class AddLegacyIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :legacy_id, :integer
  end
end
