class RollbackChangeValue < ActiveRecord::Migration
  def up
    change_column :scores, :value, :decimal
  end

  def down
    change_column :scores, :value, :decimal, precision: 10, scale: 2 
  end
end
