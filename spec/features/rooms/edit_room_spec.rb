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
    click_link "Rooms"
  end

  def create_rooms(num)
    num.times do
      FactoryGirl.create(:room)
    end
  end

  scenario "User successfully edits a room" do
    room
    sign_in_and_navigate_to_rooms_index
    click_link "edit"
    fill_in "Name", with: "New Room Name"
    click_button "Submit"

    expect(page).to have_content("New Room Name")
  end

  scenario "User does not provide valid information" do
    room
    sign_in_and_navigate_to_rooms_index
    click_link "edit"
    fill_in "Name", with: ""
    click_button "Submit"

    expect(page).to have_content("Please provide valid information.")
  end
end
