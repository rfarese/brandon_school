require 'rails_helper'

RSpec.feature "User views QR code scanner;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  scenario "User navigates to the QR code scanning page" do
    sign_in(user)
    navigate_to_qrcode_scanner(house)

    expect(page).to have_content("Scan a QR Code")
  end
end
