class CreatePatterns < ActiveRecord::Migration
  def self.up
    create_table :patterns do |t|
      t.string :name
      t.string :slug
      t.integer :organization_id
      t.string :status
      t.string :attachment
      t.text :notes
      t.string :fontcolor
      t.string :color
      t.string :group
      t.integer :category_id
      t.boolean :use_privacy, default: false

      t.timestamps
    end
    add_index :patterns, :organization_id
    add_index :patterns, :slug
    add_index :patterns, :name
    add_index :patterns, :color
    add_index :patterns, :group
    add_index :patterns, :category_id
    add_index :patterns, :use_privacy
  end

  def self.down
  drop_table :patterns
  end 
end
