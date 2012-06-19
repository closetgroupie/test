class AddLegacyIdAndLegacyUidToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :legacy_id, :integer
    add_column :carts, :legacy_uid, :integer
  end
end
