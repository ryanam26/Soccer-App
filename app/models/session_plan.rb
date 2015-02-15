class SessionPlan < ActiveRecord::Base
  belongs_to :category
  
  mount_uploader :file, FileUploader
end
