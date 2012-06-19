class AddLegacyIdToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :legacy_id, :integer
  end
end
