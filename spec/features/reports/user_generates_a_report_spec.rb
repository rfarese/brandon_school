require 'rails_helper'

RSpec.feature "User generates a new report;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:house2) { FactoryGirl.create(:house) }
  let(:tour) { FactoryGirl.create(:tour) }

  def sign_in_and_navigate_to_reports_index
    user.role = "admin"
    user.save
    sign_in(user)
    within(".top-bar-right") do
      click_on("Reports")
    end
  end

  scenario "User can select a date range" do
    sign_in_and_navigate_to_reports_index

    expect(page).to have_content("Start Date")
    expect(page).to have_content("End Date")
  end

  scenario "User successfully creates a report"

  scenario "User does not provide required information to generate a report"

end
