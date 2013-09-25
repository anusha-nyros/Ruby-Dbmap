class CreateDatabases < ActiveRecord::Migration
  def self.up
    create_table :databases do |t|
      t.string :db_name
      t.string :db_environment
      t.string :db_hosting
      t.string :db_technology
      t.text :db_usage
      t.string :db_connection_string
      t.string :db_version
      t.boolean :db_active
      t.integer :organization_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :databases
  end 
end
