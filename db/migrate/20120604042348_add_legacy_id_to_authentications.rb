class AddLegacyIdToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :legacy_id, :integer
  end
end
