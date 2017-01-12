require 'rails_helper'

RSpec.feature "User creates a room;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate
    sign_in(user)
    visit new_room_path
  end

  scenario "User views the ability to create a new room" do
    sign_in_and_navigate

    expect(current_path).to eq(new_room_path)
    expect(page).to have_content("New Room")
    expect(page).to have_field("House")
    expect(page).to have_field("Name")
    expect(page).to have_button("Submit")
  end

  scenario "User successfully creates a room with an associated QR code" do
    sign_in_and_navigate

    select(house.name, from: 'room[house_id]')
    fill_in "Name", with: "Room1"
    click_button "Submit"
    room = Room.last
    qrcode = Qrcode.last

    expect(page).to have_content("A room was successfully created.")
    expect(room.name).to eq("Room1")
    expect(room.qrcode).to eq(qrcode)
  end

  scenario "User does not provide valid and required information" do
    sign_in_and_navigate

    select(house.name, from: 'room[house_id]')
    click_button "Submit"

    expect(page).to have_content("Please provide valid information.")
    expect(Room.count).to eq(0)
  end
end
