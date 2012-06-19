class AddLegacyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :legacy_id, :integer, :limit => 2
  end
end
