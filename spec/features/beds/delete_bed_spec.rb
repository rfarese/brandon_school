require 'rails_helper'

RSpec.feature "User creates a new bed;", type: :feature do
  let(:permission)  { FactoryGirl.create(:permission) }
  let(:user)        { permission.user }
  let(:house)       { permission.house }
  let(:room)        { FactoryGirl.create(:room, house_id: house.id) }
  let(:bed)         { FactoryGirl.create(:bed, room_id: room.id, house_id: house.id) }

  def sign_in_and_navigate_to_beds_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Beds")
    end
  end

  scenario "User views ability to delete a bed" do
    bed
    room
    sign_in_and_navigate_to_beds_index

    expect(page).to have_content("delete")
  end

  # NOTE - need phantom.js for both of these tests below

  scenario "User successfully deletes a bed"

  scenario "User recieves a notice before deleting a bed"
end
