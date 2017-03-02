require 'rails_helper'

RSpec.feature "User creates a tour;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  scenario "user views link to create a new tour" do
    sign_in(user)
    within(".top-bar-right") do
      click_on("New Tour")
    end

    expect(page).to have_content("Take a Selfie")
  end

  scenario "user successfully uploads a selfie to create a new tour" do
    sign_in(user)
    within(".top-bar-right") do
      click_on("New Tour")
    end
    
    expect(Tour.count).to eq(0)

    attach_file :tour_selfie, "#{Rails.root}/spec/support/images/photo.jpg"
    select(house.name, from: 'tour[house_id]')
    click_button "Upload"

    tour = Tour.last

    expect(Tour.count).to eq(1)
    expect(tour.status).to eq("incomplete")
    expect(tour).to respond_to(:selfie)
  end
end
