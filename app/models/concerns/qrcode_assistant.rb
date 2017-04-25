module QrcodeAssistant
  def generate_qrcode_identifier
    num = Room.maximum(:qrcode_identifier) || 1
    num + 1
  end

  def assign_room_id
    qrcode.room_id = room.id
  end

  def build_qrcode_image
    qrcode.image_builder(room.qrcode_identifier)
  end

  def save_qrcode
    qrcode.save
  end

  def bind_qrcode_to_room
    room.qrcode = qrcode
  end

  def replace_qrcode_identifier
    room.qrcode_identifier = generate_qrcode_identifier
  end
end
