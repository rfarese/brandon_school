class RemoveStatusFromTours < ActiveRecord::Migration
  def change
    remove_column :tours, :status, :string
  end
end
