class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :player
  belongs_to :test

  scope :test, lambda{|test_id| where(:test_id => test_id)}
end
