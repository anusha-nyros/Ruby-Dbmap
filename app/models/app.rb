class App < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :app_desc, :name, :organization_id,:user_id, :technology
  has_many :databases , :dependent => :destroy
  belongs_to :organization
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :organization_id, message: 'already exists' 
  friendly_id :name, use: :slugged
end
