class RelationsForAccounts < ActiveRecord::Migration
  def change
    create_table :accounts_teams do |t|
      t.integer :account_id
      t.integer :team_id
      t.timestamps
    end
 
    create_table :accounts_locations do |t|
      t.integer :account_id
      t.integer :location_id
      t.timestamps
    end
 
    create_table :accounts_users do |t|
      t.integer :account_id
      t.integer :user_id
      t.timestamps
    end
  end
end
