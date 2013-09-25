class AddUsageToPatterns < ActiveRecord::Migration

  def self.up
	add_column :patterns , :how_used,:text
	add_column :patterns , :when_used,:text
	add_column :patterns , :what_problem,:text
  end

  def self.down
	remove_column :patterns , :how_used
	remove_column :patterns , :when_used
	remove_column :patterns , :what_problem
  end

end
