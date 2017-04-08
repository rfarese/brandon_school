class AddTypeToHouse < ActiveRecord::Migration
  def up
    add_column :houses, :type, :string
  end

  def down
    remove_column :houses, :type, :string
  end
end
