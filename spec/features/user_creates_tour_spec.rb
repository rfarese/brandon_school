require 'rails_helper'

RSpec.feature "User creates a tour;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  scenario "user views link to create a new tour" do
    sign_in(user)
    within(".top-bar-right") do
      click_on("New Tour")
    end

    expect(page).to have_content("Take a Selfie")
  end

  scenario "user successfully uploads a selfie to create a new tour" 
end
