class AddAssetAttachmentToPatterns < ActiveRecord::Migration
  def self.up
	add_column :patterns , :asset_attachment,:string
  end

  def self.down
	remove_column :patterns , :asset_attachment
  end
end
