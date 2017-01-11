class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :status, null: false
      t.string :selfie, null: false
      t.references :house

      t.timestamps null: false
    end

    add_index :tours, :house_id
  end
end
