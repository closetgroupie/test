class CreateCarts < ActiveRecord::Migration
  def up
    create_table :carts do |t|
      t.belongs_to :user
      t.belongs_to :purchase, :null => true, :default => nil

      t.datetime :purchased_at
      t.timestamps
    end
  end

  def down
    drop_table :carts
  end
end
