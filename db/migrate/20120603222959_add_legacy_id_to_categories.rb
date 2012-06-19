class AddLegacyIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :legacy_id, :integer, :limit => 2
  end
end
