class RenameOrderToOrderingInCategorizationSizeGroups < ActiveRecord::Migration
  def up
    rename_column :categorization_size_groups, :order, :ordering
  end

  def down
    rename_column :categorization_size_groups, :ordering, :order
  end
end
