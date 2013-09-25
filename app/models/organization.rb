class Organization < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :users, dependent: :destroy
  has_many :categories
  has_many :patterns, dependent: :destroy
  has_many :databases , dependent: :destroy
  has_many :tables , dependent: :destroy
  has_many :fields , dependent: :destroy
  has_many :hostings , dependent: :destroy
  has_many :apps , dependent: :destroy
  has_many :environments , dependent: :destroy
end
