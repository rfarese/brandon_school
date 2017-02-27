class QrCodeImageCreator
  attr_reader :identifier, :image

  def initialize(identifier)
    @identifier = identifier
  end

  def build_image
    @image = RQRCode::QRCode.new(identifier)
    build_png
  end

  def build_png
    self.image.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 120,
      border_modules: 4,
      module_px_size: 6,
      file: nil
      )
  end
end
