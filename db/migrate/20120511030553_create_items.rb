class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user
      t.references :closet
      t.string :title, :limit => 200
      t.references :segment
      t.references :category
      t.references :size
      t.integer :condition, :limit => 1
      t.references :brand
      t.string :brand_suggestion, :limit => 80
      t.text :description
      t.decimal :price, :precision => 9, :scale => 2
      t.decimal :shipping_cost, :precision => 6, :scale => 2
      t.decimal :shipping_cost_bundled, :precision => 6, :scale => 2
      t.string :shipping_from, :limit => 2
      t.boolean :shipping_abroad, :default => false
      t.text :shipping_notes

      t.timestamps
    end

    add_index :items, :user_id
    add_index :items, :closet_id
    add_index :items, :segment_id
    add_index :items, :category_id
  end
end
