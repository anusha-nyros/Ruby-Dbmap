class AddFieldsAndRelationToApps < ActiveRecord::Migration
  def self.up
  rename_column :apps, :app_name, :name
  add_column :databases , :app_id,:integer
  end

  def self.down
  rename_column :apps, :name, :app_name
  remove_column :databases , :app_id
  end

end
