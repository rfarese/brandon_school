class AddStatusEnumToTours < ActiveRecord::Migration
  def change
    add_column :tours, :status, :integer, default: 0
  end
end
