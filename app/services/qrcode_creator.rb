class QrcodeCreator
  attr_reader :room, :qrcode
  include QrcodeAssistant

  def initialize(room)
    @room = room
    @qrcode = Qrcode.new
  end

  def generate
    assign_room_id
    build_qrcode_image
    save_qrcode
    bind_qrcode_to_room
  end

  def replace_identifier
    replace_qrcode_identifier
    room 
  end
end
