class Category < ActiveRecord::Base
  has_many :tests
  has_many :session_plans
end
