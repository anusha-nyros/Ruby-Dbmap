class AddDbFileToDatabases < ActiveRecord::Migration
  def self.up
	add_column :databases , :db_file ,:string
  end

  def self.down
	remove_column :databases , :db_file
  end

end
