class AddIsCuratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_curator, :boolean, :default => false
  end
end
