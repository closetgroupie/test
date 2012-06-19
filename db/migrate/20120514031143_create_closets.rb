class CreateClosets < ActiveRecord::Migration
  def change
    create_table :closets do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
  end
end
