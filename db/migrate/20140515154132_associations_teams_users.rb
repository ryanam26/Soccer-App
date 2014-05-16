class AssociationsTeamsUsers < ActiveRecord::Migration
  def change
    create_table :teams_users, id: false do |t|
      t.belongs_to :team
      t.belongs_to :user
    end
  end
end
