class AddPlayerRefToScores < ActiveRecord::Migration
  def change
    add_reference :scores, :player, index: true
  end
end
