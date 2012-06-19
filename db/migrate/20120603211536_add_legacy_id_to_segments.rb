class AddLegacyIdToSegments < ActiveRecord::Migration
  def change
    add_column :segments, :legacy_id, :integer, :limit => 2
  end
end
