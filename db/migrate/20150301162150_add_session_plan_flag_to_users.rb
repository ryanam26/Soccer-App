class AddSessionPlanFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_plans_visible, :boolean, default: false
  end
end
