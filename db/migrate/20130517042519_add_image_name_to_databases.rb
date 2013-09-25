class AddImageNameToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :image_name, :string
  end
end
