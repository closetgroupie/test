class AddLegacyIdToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :add_legacy_id_to_photos, :string
    add_column :relationships, :legacy_id, :integer
  end
end
