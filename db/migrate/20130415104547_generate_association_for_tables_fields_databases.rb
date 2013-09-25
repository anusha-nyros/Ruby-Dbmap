class GenerateAssociationForTablesFieldsDatabases < ActiveRecord::Migration
  def up
    add_column :fields, :fieldable_id, :integer
    add_column :fields, :fieldable_type, :string
    add_column :tables, :database_id, :integer
    add_column :tables, :table_name, :string
    add_column :databases, :last_sync, :date
  end

  def down
    remove_column :fields, :fieldable_id 
    remove_column :fields, :fieldable_type 
    remove_column :tables, :database_id
    remove_column :tables, :table_name
    remove_column :databases, :last_sync
  end
end
