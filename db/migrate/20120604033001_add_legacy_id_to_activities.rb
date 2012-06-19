class AddLegacyIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :legacy_id, :integer
  end
end
