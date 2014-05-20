class Test < ActiveRecord::Base
  belongs_to :category
  has_many :scores
  has_many :users, :through => :scores

  mount_uploader :file, FileUploader

end
