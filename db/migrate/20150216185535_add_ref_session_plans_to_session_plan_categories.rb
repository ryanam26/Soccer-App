class AddRefSessionPlansToSessionPlanCategories < ActiveRecord::Migration
  def change
    change_table :session_plans do |t|
      t.belongs_to :session_plan_category
      t.remove :category_id
    end
  end
end
