class ChangeStatusAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :status, :integer, 'integer USING CAST(status AS integer)'
  end
end
