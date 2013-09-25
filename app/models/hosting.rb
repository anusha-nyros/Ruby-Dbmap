class Hosting < ActiveRecord::Base
  attr_accessible :organization_id,:user_id,:db_hosting,:db_hosting_name,:notes,:env_id,:inst_id,:description,:os,:apps,:ip
  belongs_to :organization
  belongs_to :user
  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  validates :ip,:format => { :with => @ip_regex, :message => "Invalid Ip address format"  },:allow_blank => true
# validates_presence_of :db_hosting
#  validates_presence_of :db_hosting_name
  #validates_uniqueness_of :db_hosting, scope: :organization_id
  #validates_uniqueness_of :db_hosting_name, scope: :organization_id
end
