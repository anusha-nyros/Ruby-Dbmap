class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :app_name
      t.string :technology
      t.text :app_desc
      t.integer :organization_id
      t.integer :user_id
      t.timestamps
    end
  end
  def self.down
    drop_table :apps
  end 
end
