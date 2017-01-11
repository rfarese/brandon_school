class RemoveUserIdFromHouses < ActiveRecord::Migration
  def change
    remove_column :houses, :user_id, :integer 
  end
end
