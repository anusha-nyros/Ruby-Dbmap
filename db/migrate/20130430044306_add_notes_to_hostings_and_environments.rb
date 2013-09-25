class AddNotesToHostingsAndEnvironments < ActiveRecord::Migration
  def change
     add_column :environments ,:notes,:text	
     add_column :hostings ,:notes,:text	
  end
end
