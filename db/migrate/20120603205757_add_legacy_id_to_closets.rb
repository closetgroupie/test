class AddLegacyIdToClosets < ActiveRecord::Migration
  def change
    add_column :closets, :legacy_id, :integer, limit: 2
  end
end
