require 'rails_helper'

RSpec.feature "User views all houses;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate_to_houses_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Houses")
    end
  end

  scenario "User navigates to the house index page" do
    sign_in_and_navigate_to_houses_index

    expect(current_path).to eq(houses_path)
  end

  scenario "User views all existing houses on the house index page" do
    sign_in_and_navigate_to_houses_index

    expect(page).to have_content(house.name)
    expect(page).to have_content(house.rooms.count)
    expect(page).to have_content(house.beds.count)
  end
end
