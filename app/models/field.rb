class Field < ActiveRecord::Base
  attr_accessible :database, :description, :environment, :field_name, :field_size, :field_type, :validation_edit,:organization_id,:user_id,:database_name,:table_name,:short_description
  validates :short_description,:length => {:maximum =>60} 
  belongs_to :user
  belongs_to :organization
  belongs_to :database
  belongs_to :fieldable, :polymorphic =>true
end
