class AddUserIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :user_id, :integer, references: :users
  end
end
