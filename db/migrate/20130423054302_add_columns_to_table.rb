class AddColumnsToTable < ActiveRecord::Migration
 def self.up
  add_column :tables , :database_name ,:string
  add_column :fields , :database_name ,:string
  add_column :fields , :table_name ,:string
  add_column :databases , :oftables ,:integer
  add_column :databases , :ofrecords ,:integer
  add_column :databases , :offields ,:integer
  end

  def self.down
  remove_column :tables , :database_name
  remove_column :fields, :database_name
  remove_column :fields, :table_name
  remove_column :databases, :oftables
  remove_column :databases, :ofrecords
  remove_column :databases, :offields

  end

end
