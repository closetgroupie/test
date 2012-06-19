class CreateSizeGroups < ActiveRecord::Migration
  def change
    create_table :size_groups do |t|
      t.string :name, limit: 80
      t.timestamps
    end
  end
end
