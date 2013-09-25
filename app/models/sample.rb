class Sample < ActiveRecord::Base
  attr_accessible :record_id, :table_id
  belongs_to :table
  belongs_to :record,:dependent => :destroy
end
