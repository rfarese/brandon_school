class CreateBeds < ActiveRecord::Migration
  def change
    create_table :beds do |t|
      t.string :name, null: false
      t.references :room

      t.timestamps null: false
    end

    add_index :beds, :room_id
  end
end
