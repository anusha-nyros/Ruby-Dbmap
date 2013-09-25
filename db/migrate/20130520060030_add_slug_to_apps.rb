class AddSlugToApps < ActiveRecord::Migration
  def self.up
  add_column :apps ,:slug,:string 
  end

  def self.down
  remove_column :apps ,:slug,:string
  end

end
