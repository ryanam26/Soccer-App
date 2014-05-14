class ChangeStatusAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :status, :integer, 'integer USING CAST(column_name AS integer)'
  end
end
