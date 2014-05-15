class ChangeAssociationsToLocations < ActiveRecord::Migration
  def change
    drop_table :accounts_locations
    add_column :locations, :account_id, :integer, references: :accounts
  end
end
