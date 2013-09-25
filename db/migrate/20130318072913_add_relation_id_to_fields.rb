class AddRelationIdToFields < ActiveRecord::Migration
  def self.up
  add_column :fields , :organization_id ,:integer
  add_column :fields , :user_id ,:integer
  end

  def self.down
  remove_column :fields , :organization_id
  remove_column :fields , :user_id
  end

end
