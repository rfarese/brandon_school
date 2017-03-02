require 'rails_helper'

RSpec.feature "User views all rooms;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:room)  { FactoryGirl.create(:room, house_id: house.id) }
  let(:room2) { FactoryGirl.create(:room, house_id: house.id) }

  def sign_in_and_navigate_to_rooms_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Rooms")
    end
  end

  scenario "User views ability to delete a room" do
    room
    sign_in_and_navigate_to_rooms_index

    expect(page).to have_content("delete")
  end

  # NOTE - need phantom.js for both of these tests below

  scenario "User successfully deletes a room"

  scenario "User recieves a notice before deleting a room"
end
