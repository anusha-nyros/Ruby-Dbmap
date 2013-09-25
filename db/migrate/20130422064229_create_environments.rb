class CreateEnvironments < ActiveRecord::Migration
  def self.up
    create_table :environments do |t|
      t.integer :organization_id
      t.integer :user_id
      t.string :db_environment
      t.string :db_environment_name
      t.timestamps
    end
  end
  def self.down
    drop_table :environments
  end 
end
