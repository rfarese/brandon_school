class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :house, index: true
      
      t.timestamps null: false
    end
  end
end
