class ChangeStatusAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :status, :integer
  end
end
