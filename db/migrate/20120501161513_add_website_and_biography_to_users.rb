class AddWebsiteAndBiographyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_column :users, :biography, :text
  end
end
