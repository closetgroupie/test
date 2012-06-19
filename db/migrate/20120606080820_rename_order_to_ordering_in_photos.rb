class RenameOrderToOrderingInPhotos < ActiveRecord::Migration
  def up
    rename_column :photos, :order, :ordering
  end

  def down
    rename_column :photos, :ordering, :order
  end
end
