class CreateScores < ActiveRecord::Migration
  def change
    execute "DROP TABLE IF EXISTS scores"
    create_table :scores do |t|
      t.belongs_to :user
      t.belongs_to :test
      t.decimal :value

      t.timestamps
    end
  end
end
