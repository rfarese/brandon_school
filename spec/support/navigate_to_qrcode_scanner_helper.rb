module NavigateToQrcodeScannerHelper
  def navigate_to_qrcode_scanner(house)
    within(".top-bar-right") do
      click_on("New Tour")
    end
    attach_file :tour_selfie, "#{Rails.root}/spec/support/images/photo.jpg"
    select(house.name, from: 'tour[house_id]')
    click_button "Upload"
  end
end
