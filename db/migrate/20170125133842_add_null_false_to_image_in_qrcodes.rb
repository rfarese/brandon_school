class AddNullFalseToImageInQrcodes < ActiveRecord::Migration
  def change
    change_column :qrcodes, :image, :string, null: false
  end
end
