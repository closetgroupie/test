class AddFilenameSeedToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :filename_seed, :string
  end
end
