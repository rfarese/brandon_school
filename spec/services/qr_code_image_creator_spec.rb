require 'rails_helper'

RSpec.describe QrCodeImageCreator, type: :model do
  let(:room) { FactoryGirl.create(:room) }

  describe "#build_image" do
    it "builds a QR code image" do
      room.qrcode_identifier = room.generate_qrcode_identifier
      room.save

      qrcode = QrCodeImageCreator.new(room.qrcode_identifier.to_s)
      qrcode.build_image

      expect(qrcode.identifier).to eq(room.qrcode_identifier.to_s)
    end
  end
end
