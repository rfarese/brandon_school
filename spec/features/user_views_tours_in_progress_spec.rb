require 'rails_helper'

RSpec.feature "User visits tours in progress dashboard;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:tour) { FactoryGirl.create(:tour) }

  def sign_in_admin_user
    user.role = "admin"
    user.save
    sign_in(user)
  end

  def navigate_to_tours_in_progress
    within(".top-bar-right") do
      click_on("Tours in Progress")
    end
  end

  scenario "User can navigate to the tours in progress page" do
    sign_in_admin_user
    navigate_to_tours_in_progress

    expect(current_path).to eq(tours_in_progress_path)
  end

  scenario "User views tours seperated by house"

  scenario "User views the tour start time, staff selfie, and tour status"

  scenario "User views all tours in the last 24 hours"

  scenario "User can select select a tour to view its details"

end
