class CreateSessionPlanCategory < ActiveRecord::Migration
  def change
    create_table :session_plan_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
