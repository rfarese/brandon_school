class QrcodeReplacer
  attr_reader :room

  def initialize(room)
    @room = room
  end

  def replace
    replace_qrcode_identifier
    delete_current_qrcode
    create_new_qr_code
    save_room
  end

  def replace_qrcode_identifier
    room.qrcode_identifier = room.generate_qrcode_identifier
  end

  def delete_current_qrcode
    room.qrcode.destroy
  end

  def create_new_qr_code
    room.create_new_qr_code
  end

  def save_room
    room.save
  end
end
