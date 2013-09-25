class AddFeatureToTable < ActiveRecord::Migration
  def change
     add_column :tables ,:feature_types,:string	
  end
end
