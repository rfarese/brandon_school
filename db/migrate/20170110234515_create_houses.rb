class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name, null: false
      t.integer :user_id, null: false  

      t.timestamps null: false
    end
  end
end
