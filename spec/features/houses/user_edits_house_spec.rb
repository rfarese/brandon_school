require 'rails_helper'

RSpec.feature "User edits a house;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate_to_houses_index
    user.role = "admin"
    sign_in(user)
    click_link "Houses"
  end

  scenario "User navigates to the new house page" do
    sign_in_and_navigate_to_houses_index
    click_link "edit"

    expect(current_path).to eq(edit_house_path(house))
  end

  scenario "User successfully edits a house" do
    sign_in_and_navigate_to_houses_index
    click_link "edit"
    fill_in "Name", with: "Edited House Name"
    click_button "Submit"

    expect(House.last.name).to eq("Edited House Name")
    expect(page).to have_content("House Edited")
  end

  scenario "User does not provide valid information" do
    sign_in_and_navigate_to_houses_index
    click_link "edit"
    fill_in "Name", with: ""
    click_button "Submit"

    expect(House.last.name).to eq(house.name)
    expect(page).to have_content("House Not Edited")
  end
end
