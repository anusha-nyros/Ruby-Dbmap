class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.string :environment
      t.string :database
      t.text :description
      t.string :field_name
      t.string :validation_edit
      t.string :field_type
      t.integer :field_size
      t.timestamps
    end
  end

  def self.down
  drop_table :fields
  end
end
