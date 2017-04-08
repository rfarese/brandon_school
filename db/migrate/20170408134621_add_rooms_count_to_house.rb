class AddRoomsCountToHouse < ActiveRecord::Migration
  def up
    add_column :houses, :rooms_count, :integer, default: 0, null: false

    ids = House.all.pluck(:id)
    ids.each do |id|
      House.reset_counters(id, :rooms)
    end
  end

  def down
    remove_column :houses, :rooms_count
  end
end
