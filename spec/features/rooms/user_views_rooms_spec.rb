require 'rails_helper'

RSpec.feature "User views all rooms;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:room)  { FactoryGirl.create(:room, house_id: house.id) }
  let(:room2) { FactoryGirl.create(:room, house_id: house.id) }

  def sign_in_and_navigate_to_rooms_index
    user.role = "admin"
    sign_in(user)
    click_link "Rooms"
  end

  def create_rooms(num)
    num.times do
      FactoryGirl.create(:room)
    end
  end

  scenario "User navigates to the room index page" do
    sign_in_and_navigate_to_rooms_index

    expect(current_path).to eq(rooms_path)
  end

  scenario "User views all existing houses on the house index page" do
    room
    room2
    sign_in_and_navigate_to_rooms_index

    expect(page).to have_content(room.name)
    expect(page).to have_content(room2.name)
  end

  scenario "User views pagination feature for rooms" do
    create_rooms(10)
    sign_in_and_navigate_to_rooms_index

    expect(page).to have_css("nav.pagination")
  end
end
