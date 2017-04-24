class RemoveSelfieFromTours < ActiveRecord::Migration
  def up
    remove_column :tours, :selfie, :string
  end

  def down
    add_column :tours, :selfie, :string 
  end
end
