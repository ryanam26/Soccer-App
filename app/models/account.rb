class Account < ActiveRecord::Base
  has_many :teams
  has_many :locations
  has_and_belongs_to_many :users

  extend EnumerateIt
  has_enumeration_for :status, :with => Status, :create_helpers => true
  
  scope :active, lambda{where(:status => Status::ACTIVE)}
  scope :inactive, lambda{where(:status => Status::INACTIVE)}

end
