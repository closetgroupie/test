class AddLegacyIdAndLegacyUidToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :legacy_id, :integer
    add_column :orders, :legacy_uid, :integer
  end
end
