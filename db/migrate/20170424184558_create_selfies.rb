class CreateSelfies < ActiveRecord::Migration
  def change
    create_table :selfies do |t|
      t.string :image, null: false
    end
  end
end
