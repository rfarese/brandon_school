require_relative 'qr_code_image_creator'

class Qrcode < ActiveRecord::Base
  belongs_to :room
  mount_uploader :image, ImageUploader

  def image_builder
    tmp_path = Rails.root.join('tmp', "Room#{self.room_id}_qrcode.png")
    qrcode = QrCodeImageCreator.new(self.room_id.to_s)
    qrcode.build_image.save(tmp_path)
    open_image_file(tmp_path)
    remove_tmp_path(tmp_path)
  end

  def open_image_file(tmp_path)
    File.open(tmp_path) do |file|
      self.image = file
    end
  end

  def remove_tmp_path(tmp_path)
    File.delete(tmp_path)
  end

  def room_name
    Room.find(self.room_id).name
  end

  def unique_identifier 
    Room.find(self.room_id).generate_qrcode_identifier
  end
end
