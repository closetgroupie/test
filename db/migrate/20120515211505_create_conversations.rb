class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :conversable, polymorphic: true
      t.references :sender
      t.references :recipient
      t.timestamps
    end
  end
end
