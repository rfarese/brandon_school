require 'rails_helper'

RSpec.feature "User views all rooms;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:qrcode) { FactoryGirl.create(:qrcode) }
  let(:room)  { qrcode.room }

  def sign_in_and_navigate_to_rooms_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Rooms")
    end
  end

  scenario "User successfully edits a room" do
    room
    sign_in_and_navigate_to_rooms_index
    visit edit_room_path(room)
    fill_in "Name", with: "New Room Name"
    click_button "Submit"

    expect(page).to have_content("New Room Name")
  end

  scenario "User does not provide valid information" do
    room
    sign_in_and_navigate_to_rooms_index
    visit edit_room_path(room)
    fill_in "Name", with: ""
    click_button "Submit"

    expect(page).to have_content("Please provide valid information.")
  end
end
