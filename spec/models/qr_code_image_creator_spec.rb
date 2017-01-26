require 'rails_helper'
require_relative '../../app/models/qr_code_image_creator'

RSpec.describe QrCodeImageCreator, type: :model do
  let(:room) { FactoryGirl.create(:room) }

  describe "#build_image" do
    it "builds a QR code image" do
      qrcode = QrCodeImageCreator.new(room.id.to_s)
      qrcode.build_image

      expect(qrcode.room_id).to eq(room.id.to_s)
    end
  end
end
