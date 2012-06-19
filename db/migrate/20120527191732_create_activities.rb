class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.belongs_to :user,     :null => false
      t.integer :action_id,   :null => false
      t.string  :action_type, :null => false, :limit => 30
      t.integer :entity_id,   :null => false
      t.string  :entity_type, :null => false, :limit => 30
      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, [:action_id, :action_type]
    add_index :activities, [:entity_id, :entity_type]
  end

  def down
    drop_table :activities
  end
end
