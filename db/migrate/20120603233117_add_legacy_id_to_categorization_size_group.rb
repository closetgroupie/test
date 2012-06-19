class AddLegacyIdToCategorizationSizeGroup < ActiveRecord::Migration
  def change
    add_column :categorization_size_groups, :legacy_id, :integer
  end
end
