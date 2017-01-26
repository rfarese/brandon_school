require 'rails_helper'

RSpec.feature "User creates a new bed;", type: :feature do
  let(:permission)  { FactoryGirl.create(:permission) }
  let(:user)        { permission.user }
  let(:house)       { permission.house }
  let(:room)        { FactoryGirl.create(:room, house_id: house.id) }
  let(:bed)         { FactoryGirl.create(:bed, room_id: room.id) }

  def sign_in_and_navigate_to_beds_index
    user.role = "admin"
    sign_in(user)
    click_link "Beds"
  end

  scenario "User successfully creates a new bed" do
    bed
    room
    sign_in_and_navigate_to_beds_index
    click_link "New Bed"
    fill_in "Name", with: "Bed1"
    select(room.name, from: 'bed[room_id]')
    click_button "Submit"

    expect(page).to have_content("New Bed")
    expect(page).to have_content("New Bed Saved")
  end

  scenario "User does not provide valid information" do
    sign_in_and_navigate_to_beds_index
    click_link "New Bed"
    click_button "Submit"

    expect(page).to have_content("Please provide valid information.")
  end
end
