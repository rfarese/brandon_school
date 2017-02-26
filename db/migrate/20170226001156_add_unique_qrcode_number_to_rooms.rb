class AddUniqueQrcodeNumberToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :qrcode_identifier, :integer 
  end
end
