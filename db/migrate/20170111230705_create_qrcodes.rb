class CreateQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.string :image
      t.references :room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
