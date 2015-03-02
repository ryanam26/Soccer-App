class SetSessionPlansFlagInUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      unless user.standard?
        user.update_attributes :session_plans_visible => true
      end
    end
  end
end
