class CreateHostings < ActiveRecord::Migration
  def self.up
    create_table :hostings do |t|
      t.integer :organization_id
      t.integer :user_id
      t.string :db_hosting
      t.string :db_hosting_name
      t.timestamps
    end
  end
  def self.down
    drop_table :hostings
  end 
end
