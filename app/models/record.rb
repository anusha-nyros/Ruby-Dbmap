class Record < ActiveRecord::Base
  attr_accessible :record
  has_many :samples
end
