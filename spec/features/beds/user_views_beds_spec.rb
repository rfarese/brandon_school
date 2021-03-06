require 'rails_helper'

RSpec.feature "User views all beds;", type: :feature do
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

  scenario "User navigates to the bed index page" do
    sign_in_and_navigate_to_beds_index

    expect(current_path).to eq(beds_path)
  end

  scenario "User views all existing beds" do
    bed
    sign_in_and_navigate_to_beds_index

    expect(page).to have_content(bed.name)
    expect(page).to have_content(bed.house.name)
    expect(page).to have_content(bed.room.name)
  end
end
