class AddTopUsedFieldToTables < ActiveRecord::Migration
  def change
     add_column :tables ,:top_used,:boolean	
  end
end
