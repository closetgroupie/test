class AddLegacyIdToSizes < ActiveRecord::Migration
  def change
    add_column :sizes, :legacy_id, :integer
  end
end
