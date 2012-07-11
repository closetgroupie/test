class CreateCuratorApplications < ActiveRecord::Migration
  def change
    create_table :curator_applications do |t|
      t.references :user, :null => true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :primary
      t.string :secondary
      t.string :city
      t.string :state
      t.string :zip
      t.text :about

      t.timestamps
    end
  end
end
