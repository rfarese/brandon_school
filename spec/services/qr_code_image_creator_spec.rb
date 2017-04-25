require 'rails_helper'

RSpec.describe QrCodeImageCreator, type: :model do
  let(:image_creator) { QrCodeImageCreator.new("10") }

  describe "#build_image" do
    it "builds a QR code image with the RQRCode module" do
      image_creator.build_image

      expect(image_creator.image.class.name).to eq("RQRCode::QRCode")
    end
  end
end
