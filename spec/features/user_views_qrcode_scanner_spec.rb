require 'rails_helper'

RSpec.feature "User views QR code scanner;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  scenario "User navigates to the QR code scanning page" 
end
