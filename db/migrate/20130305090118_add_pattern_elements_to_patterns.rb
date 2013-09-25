class AddPatternElementsToPatterns < ActiveRecord::Migration
  def self.up
  add_column :patterns , :pat_html,:text,:limit => 4294967295
  add_column :patterns , :pat_js,:text,:limit => 4294967295
  add_column :patterns , :pat_css,:text,:limit => 4294967295
  end

  def self.down
  remove_column :patterns , :pat_html
  remove_column :patterns , :pat_js
  remove_column :patterns , :pat_css
  end 
end
