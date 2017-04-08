class AddBedsCountToRoom < ActiveRecord::Migration
  def up
    add_column :rooms, :beds_count, :integer, default: 0, null: false

    Room.connection.execute <<-SQL
      UPDATE rooms
      SET beds_count =
      (SELECT COUNT(*)
       FROM beds
       WHERE room_id = rooms.id)
    SQL
  end

  def down
    remove_column :rooms, :beds_count
  end
end
