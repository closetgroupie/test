class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :name, :limit => 30
      t.string :slug, :limit => 30

      t.timestamps
    end
  end
end
