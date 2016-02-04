class AddVideoLinkToSessionPlans < ActiveRecord::Migration
  def change
    add_column :session_plans, :link, :string
  end
end
