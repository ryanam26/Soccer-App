class ChangeType < ActiveRecord::Migration
  def change
    rename_column :users, :type, :type_user
  end
end
