class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :organization_id
      t.string :slug
      t.integer :position
      t.boolean :use_privacy, :default => false
      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, :organization_id
    add_index :categories, :slug
    add_index :categories, :position
    add_index :categories, :use_privacy
  end
  def self.down
    drop_table :categories
  end 
end
