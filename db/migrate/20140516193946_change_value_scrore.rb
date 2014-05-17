class ChangeValueScrore < ActiveRecord::Migration
  def change
    change_column :scores, :value, :decimal, precision: 10, scale: 2 
  end
end
