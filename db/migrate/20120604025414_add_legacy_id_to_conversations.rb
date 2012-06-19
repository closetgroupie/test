class AddLegacyIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :legacy_id, :integer, limit: 2
  end
end
