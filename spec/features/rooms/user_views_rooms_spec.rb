require 'rails_helper'

RSpec.feature "User views all rooms;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:qrcode) { FactoryGirl.create(:qrcode) }
  let(:qrcode2) { FactoryGirl.create(:qrcode) }
  let(:room)  { qrcode.room }
  let(:room2) { qrcode2.room }

  def sign_in_and_navigate_to_rooms_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Rooms")
    end
  end

  def create_rooms(num)
    num.times do
      FactoryGirl.create(:qrcode)
    end
  end

  scenario "User navigates to the room index page" do
    sign_in_and_navigate_to_rooms_index

    expect(current_path).to eq(rooms_path)
  end

  scenario "User views all existing rooms" do
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
