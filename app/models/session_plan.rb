class SessionPlan < ActiveRecord::Base
  belongs_to :session_plan_category
  
  mount_uploader :file, FileUploader
end
