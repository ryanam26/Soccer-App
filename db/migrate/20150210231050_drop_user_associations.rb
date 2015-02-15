class DropUserAssociations < ActiveRecord::Migration
  def up
    drop_table :teams_users
    remove_column :users, :birthday
    remove_column :scores, :user_id
    
  end
  
  def down
    create_join_table :teams, :users, id: false do |t|
      t.index :team_id
      t.index :user_id
    end
    
    add_column :users, :birthday, :date
    add_column :scores, :user_id, :integer
    
    User.all.each do |user|
      if user.has_players?
        user.birthday = player.first.birthday
        user.players.each do |player|
          user.scores << player.scores
          user.teams << player.teams
        end
      else
        user.birthday = Date.today
      end
    end
  end
end
