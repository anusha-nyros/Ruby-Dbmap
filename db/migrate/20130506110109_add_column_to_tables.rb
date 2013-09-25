class AddColumnToTables < ActiveRecord::Migration
  def change
    add_column :tables, :column_type, :text
  end
end
