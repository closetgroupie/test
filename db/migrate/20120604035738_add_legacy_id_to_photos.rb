class AddLegacyIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :legacy_id, :integer
  end
end
