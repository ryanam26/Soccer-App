class AddlevelToTests < ActiveRecord::Migration
  def change
    add_column :tests, :level, :integer
  end
end
