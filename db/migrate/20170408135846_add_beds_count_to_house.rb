class AddBedsCountToHouse < ActiveRecord::Migration
  def up
    add_column :houses, :beds_count, :integer, default: 0, null: false

    House.connection.execute <<-SQL
      UPDATE houses
      SET beds_count =
      (SELECT COUNT(*)
       FROM beds
       WHERE house_id = houses.id)
    SQL
  end

  def down
    remove_column :houses, :beds_count
  end
end
