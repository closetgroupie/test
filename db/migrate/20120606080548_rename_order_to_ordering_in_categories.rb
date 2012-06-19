class RenameOrderToOrderingInCategories < ActiveRecord::Migration
  def up
    rename_column :categories, :order, :ordering
  end

  def down
    rename_column :categories, :order, :ordering
  end
end
