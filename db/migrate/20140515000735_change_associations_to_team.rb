class ChangeAssociationsToTeam < ActiveRecord::Migration
  def change
    drop_table :accounts_teams
    add_column :teams, :account_id, :integer, references: :accounts
  end
end
