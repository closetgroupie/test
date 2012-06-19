class AddUniqueIdToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :unique_id, :string, :limit => 25
  end
end
