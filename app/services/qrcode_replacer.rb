class QrcodeReplacer
  attr_reader :room, :qrcode
  include QrcodeAssistant

  def initialize(room)
    @room = room
    @qrcode = Qrcode.new
  end

  def replace
    replace_qrcode_identifier
    delete_current_qrcode
    create_new_qr_code
    save_room
  end

  def delete_current_qrcode
    room.qrcode.destroy
  end

  def create_new_qr_code
    assign_room_id
    build_qrcode_image
    save_qrcode
    bind_qrcode_to_room
  end

  def save_room
    room.save
  end
end
