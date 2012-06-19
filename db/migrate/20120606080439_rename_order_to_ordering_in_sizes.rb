class RenameOrderToOrderingInSizes < ActiveRecord::Migration
  def up
    rename_column :sizes, :order, :ordering
  end

  def down
    rename_column :sizes, :ordering, :order
  end
end
