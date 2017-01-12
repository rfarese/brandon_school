require 'rails_helper'

RSpec.feature "User scans a QR code;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  scenario "User navigates to the QR code scanning page" do
    sign_in(user)
    navigate_to_qrcode_scanner(house)

    expect(current_path).to eq(new_qrcode_scan_path)
  end
end
