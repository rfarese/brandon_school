require 'rails_helper'

RSpec.describe Qrcode, type: :model do
  let(:room) { FactoryGirl.create(:room) }

  it { should respond_to(:image) }
  it { should belong_to(:room) }

  describe "#build_image" do
    it "builds a QR code image" do
      qrcode = Qrcode.new(room_id: room.id)
      qrcode.build_image
      image = qrcode.image.file

      expect(image.content_type).to eq("image/png")
    end
  end

  describe "#room_name" do
    it 'returns the name of the room that the QR code is associated with' do
      qrcode = Qrcode.new(room_id: room.id)

      expect(qrcode.room_name).to eq(room.name)
    end
  end 
end
