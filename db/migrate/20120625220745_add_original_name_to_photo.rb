class AddOriginalNameToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :original_name, :string
  end
end
