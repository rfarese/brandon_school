class AddSelfieToTours < ActiveRecord::Migration
  def change
    add_column :tours, :selfie_id, :integer, index: true, unique: true, foreign_key: true  
  end
end
