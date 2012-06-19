class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      # http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      t.references :user
      t.string :country, :null => false, :limit => 2
      t.string :recipient, :null => false, :limit => 120
      t.string :primary, :null => false, :limit => 120
      t.string :secondary, :limit => 120
      # http://en.wikipedia.org/wiki/List_of_long_place_names
      t.string :city, :null => false, :limit => 80
      t.string :state, :limit => 80
      # http://en.wikipedia.org/wiki/Postal_codes
      t.string :zip, :limit => 12

      t.timestamps
    end
  end

  def down
    drop_table :addresses
  end
end
