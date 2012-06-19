class AddLegacyIdToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :legacy_id, :integer, limit: 2
  end
end
