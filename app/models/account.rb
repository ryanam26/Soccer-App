class Account < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :users

end
