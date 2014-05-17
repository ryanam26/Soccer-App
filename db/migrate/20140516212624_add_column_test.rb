class AddColumnTest < ActiveRecord::Migration
  def change
    add_column :tests, :type_unit, :integer
  end
end
