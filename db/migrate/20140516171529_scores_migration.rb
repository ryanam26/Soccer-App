class ScoresMigration < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to :test
      t.belongs_to :user
      t.decimal :value
      t.timestamps
    end
  end
end
