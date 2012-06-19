class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :order
      t.belongs_to :item

      t.timestamps
    end
  end
end
