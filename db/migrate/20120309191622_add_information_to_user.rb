class AddInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :active, :boolean

  end
end
