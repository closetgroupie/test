class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.references :closet
      t.text :content

      t.timestamps
    end
  end
end
