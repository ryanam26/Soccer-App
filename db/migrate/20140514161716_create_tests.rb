class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.belongs_to :category
      t.string :name
      t.string :file

      t.timestamps
    end
  end
end
