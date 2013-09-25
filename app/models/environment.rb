class Environment < ActiveRecord::Base
  attr_accessible :organization_id,:user_id,:db_environment,:db_environment_name,:notes
  belongs_to :organization
  belongs_to :user
  validates_presence_of :db_environment
  validates_presence_of :db_environment_name
#  validates_uniqueness_of :db_environment, scope: :organization_id
#  validates_uniqueness_of :db_environment_name, scope: :organization_id
end
