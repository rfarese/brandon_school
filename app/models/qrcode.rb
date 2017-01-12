class Qrcode < ActiveRecord::Base
  belongs_to :room
  mount_uploader :image, ImageUploader

  def build_image
    tmp_path = Rails.root.join('tmp', "Room#{self.room_id}_qrcode.png")
    qrcode = RQRCode::QRCode.new("#{self.room_id}")
    png = build_png(qrcode, tmp_path)

    File.open(tmp_path) do |file|
      self.image = file
    end

    File.delete(tmp_path)
  end

  def room_name
    Room.find(self.room_id).name
  end

  def build_png(qrcode, tmp_path)
    qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 120,
      border_modules: 4,
      module_px_size: 6,
      file: nil
      ).save(tmp_path)
  end
end
