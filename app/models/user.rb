class User < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :organization, counter_cache: true
  has_and_belongs_to_many :categories # category that user have permission to
  has_and_belongs_to_many :patterns # pattern that user have permission
  has_many :databases 
  has_many :hostings , dependent: :destroy
  has_many :apps , dependent: :destroy
  has_many :environments , dependent: :destroy
  attr_accessor :organization_name
  attr_accessible :username, :name, :group, :active, :email, :password, :password_confirmation, :admin, :organization, as: :admin
  attr_accessible :username, :name, :group, :email, :password, :password_confirmation, :organization_name
  
  validate :organization_name_if_no_organization
  validates_presence_of :name
  validates_presence_of :organization
  validates_presence_of :password, :on => :create
  validates :password, length: { minimum: 5 }, confirmation: true, unless: "password.blank?"
  validates :username, uniqueness: true, presence: true, format: { with: /^[\w\d]+$/ }, length: { minimum: 5 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true
  
  def organization_name_if_no_organization
    errors.add(:organization_name, "can't be blank") if (organization && organization.name.blank?) && organization_name.blank?
  end
  
  def all_categories
    raise "User does not have organization" unless organization
    self.organization.categories
  end
  
  def permitted_categories
    raise "User does not have organization" unless organization
    self.organization.categories.where('use_privacy = ? OR (categories.id IN (?))', false, self.categories)
  end
  
  def user_categories
    self.admin? ? all_categories : permitted_categories
  end
  
  def all_patterns
    raise "User does not have organization" unless organization
    self.organization.patterns
  end
  
  def permitted_patterns
    raise "User does not have organization" unless organization
    permitted_categories = self.permitted_categories
    self.organization.patterns.joins('LEFT OUTER JOIN categories on categories.id = patterns.category_id').where('(categories.id is NULL OR categories.use_privacy = ? OR categories.id in (?)) AND (patterns.use_privacy = ? OR (patterns.id IN (?)))', false, permitted_categories, false, self.patterns)
  end
  
  def user_patterns
    self.admin? ? all_patterns : permitted_patterns
  end
  
#  def all_activities
#    raise "User does not have organization" unless organization
#    self.organization.activities
#  end
#  
#  def permitted_activities
#    raise "User does not have organization" unless organization
#    pfolder = self.permitted_folders.pluck(:id)
#    
#    #binding.pry
#    self.organization.activities.joins(:category).joins('LEFT OUTER JOIN folders f on f.id = categories.folder_id').where('(f.id IS NULL OR f.use_privacy = ? OR f.id in (?)) AND (categories.use_privacy = ? OR (categories.id IN (?)))', false,  pfolder, false, self.categories)
#  end
#  
#  def user_activities
#    self.admin? ? all_activities : permitted_activities
#  end
end
