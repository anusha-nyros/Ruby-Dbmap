class Table < ActiveRecord::Base
  attr_accessible :database, :description, :environment, :ofcolumns, :ofrows,:table_type,:organization_id,:user_id,:table_name,:database_name,:top_used,:feature_types,:column_type,:short_description
  validates :short_description,:length => {:maximum =>60}
  belongs_to :user
  belongs_to :organization
  belongs_to :database
  has_many :fields, :as => :fieldable,:dependent => :destroy
  has_many :records,:through => :samples,:dependent => :destroy
  has_many :samples,:dependent => :destroy
end