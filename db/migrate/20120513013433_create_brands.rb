class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.references :segment
      t.string :name, :limit => 50
      t.string :slug, :limit => 50

      t.timestamps
    end
  end
end
