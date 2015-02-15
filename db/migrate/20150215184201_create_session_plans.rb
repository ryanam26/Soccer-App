class CreateSessionPlans < ActiveRecord::Migration
  def change
    create_table :session_plans do |t|
      t.belongs_to :category
      t.string :name
      t.string :file

      t.timestamps
    end
  end
end
