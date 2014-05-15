class Account < ActiveRecord::Base
  has_many :teams
  has_many :locations
  has_and_belongs_to_many :users

end
