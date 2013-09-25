class CreatePatternsUsers < ActiveRecord::Migration
   def change
    create_table :patterns_users do |t|
      t.integer :pattern_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :patterns_users, :pattern_id
    add_index :patterns_users, :user_id
  end
end
