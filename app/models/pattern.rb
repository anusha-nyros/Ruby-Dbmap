class Pattern < ActiveRecord::Base
  extend FriendlyId
  belongs_to :organization
  belongs_to :category
  has_and_belongs_to_many :users # user that can access the category if self.use_privacy?
  
  attr_accessible :name, :color, :group, :user_tokens, :use_privacy,:fontcolor, :notes,:attachment,:status,:what_problem,:when_used,:how_used,:asset_attachment,:pat_css,:pat_html,:pat_js
  
  validates_presence_of :name
  validates_presence_of :organization
  validates_uniqueness_of :name, scope: :organization_id, message: 'already exists' 
  validates_presence_of :category_id
  validates_length_of :color, maximum: 7
  validates_presence_of :status
  
  friendly_id :name, use: :slugged
 mount_uploader :attachment, PatternAttachmentUploader
 mount_uploader :asset_attachment, PatternAssetAttachmentUploader
  
  attr_reader :user_tokens
  
  def user_tokens=(ids)
    self.user_ids = ids.split(',')
  end
  
  def check_permission(user)
    return true if !self.use_privacy? || (user.admin? && user.organization == self.organization)
    
    self.users.where(['users.id = ?', user]).count > 0
  end
end
