class CreateCategorizationSizeGroups < ActiveRecord::Migration
  def change
    create_table :categorization_size_groups do |t|
      t.belongs_to :segment
      t.belongs_to :category
      t.belongs_to :size_group
      t.integer :order, limit: 3
      t.timestamps
    end
  end
end
