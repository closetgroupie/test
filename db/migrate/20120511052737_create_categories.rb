class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :segment
      t.string :name, :limit => 40
      t.string :slug, :limit => 40
      t.integer :order, :limit => 2
      t.integer :parent_id, :limit => 2

      t.timestamps
    end
    add_index :categories, :parent_id
  end
end
