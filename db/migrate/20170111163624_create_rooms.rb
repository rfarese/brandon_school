class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.references :house

      t.timestamps null: false
    end

    add_index :rooms, :house_id
  end
end
