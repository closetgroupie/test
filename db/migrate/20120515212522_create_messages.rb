class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :conversation
      t.text :content
      t.boolean :unread, default: true

      t.timestamps
    end
  end
end
