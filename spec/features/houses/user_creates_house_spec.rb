require 'rails_helper'

RSpec.feature "User creates a house;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate_to_houses_index
    user.role = "admin"
    user.save
    sign_in(user)
    click_link "Houses"
  end

  scenario "User navigates to the new house page" do
    sign_in_and_navigate_to_houses_index
    click_link "New House"

    expect(current_path).to eq(new_house_path)
  end

  scenario "User successfully creates a new house" do
    sign_in_and_navigate_to_houses_index
    click_link "New House"
    fill_in "Name", with: "New House Name"
    click_button "Submit"

    expect(House.count).to eq(2)
    expect(House.last.name).to eq("New House Name")
    expect(page).to have_content("New House Saved")
  end

  scenario "User does not provide valid information" do
    sign_in_and_navigate_to_houses_index
    click_link "New House"
    click_button "Submit"

    expect(House.count).to eq(1)
    expect(page).to have_content("House Not Saved")
  end
end
