class AddDesctiptionColumnToTables < ActiveRecord::Migration
  def change
    add_column :tables, :short_description, :string,:limit => 60
    add_column :fields, :short_description, :string,:limit => 60
    add_column :databases, :short_description, :string,:limit => 60
  end
end
