class Account < ActiveRecord::Base
  has_many :teams
  has_many :locations
  has_and_belongs_to_many :users

  scope :active, lambda{where(:status => Status::ACTIVE)}
  scope :inactive, lambda{where(:status => Status::INACTIVE)}

  extend EnumerateIt
  has_enumeration_for :status, :with => Status, :create_helpers => true
  
  before_create :activate
  
  def activate
    status = Status::ACTIVE
  end
  
  def deactivate
    status = Status::DEACTIVE
  end
end
