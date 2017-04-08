class AddRoomsCountToHouse < ActiveRecord::Migration
  def up
    add_column :houses, :rooms_count, :integer, default: 0, null: false

    House.connection.execute <<-SQL
      UPDATE houses
      SET rooms_count =
      (SELECT COUNT(*)
       FROM rooms
       WHERE house_id = houses.id)
    SQL
  end

  def down
    remove_column :houses, :rooms_count
  end
end
