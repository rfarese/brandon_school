class AddHouseToBeds < ActiveRecord::Migration
  def change
    add_reference :beds, :house, index: true, foreign_key: true
  end
end
