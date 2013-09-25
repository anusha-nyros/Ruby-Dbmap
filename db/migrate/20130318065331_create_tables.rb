class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :tables do |t|
      t.string :environment
      t.string :database
      t.string :table_type
      t.text :description
      t.integer :ofrows
      t.integer :ofcolumns
      t.integer :user_id
      t.integer :organization_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tables
  end
end
