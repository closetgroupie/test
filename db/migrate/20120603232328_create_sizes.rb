class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.belongs_to :size_group
      t.string :name, limit: 30
      t.integer :order
      t.timestamps
    end
  end
end
