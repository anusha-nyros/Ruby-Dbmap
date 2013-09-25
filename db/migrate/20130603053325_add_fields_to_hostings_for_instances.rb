class AddFieldsToHostingsForInstances < ActiveRecord::Migration

  def self.up
  
	add_column :hostings,:env_id,:string
	add_column :hostings,:inst_id,:string
	add_column :hostings,:description,:text
	add_column :hostings,:os,:string
	add_column :hostings,:apps,:text
	add_column :hostings,:ip,:string

  end

  def self.down
	
	remove_column :hostings,:env_id
	remove_column :hostings,:inst_id
	remove_column :hostings,:description
	remove_column :hostings,:os
	remove_column :hostings,:apps
	remove_column :hostings,:ip

  end

end
