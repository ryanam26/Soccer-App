class AddLinkToTests < ActiveRecord::Migration
  def change
    add_column :tests, :link, :string
  end
end
