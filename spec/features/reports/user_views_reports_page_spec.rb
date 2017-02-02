require 'rails_helper'

RSpec.feature "User visits reports page;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }
  let(:house2) { FactoryGirl.create(:house) }
  let(:tour) { FactoryGirl.create(:tour) }

  def sign_in_and_navigate_to_reports_index
    user.role = "admin"
    user.save
    sign_in(user)
    click_link "Reports"
  end

  scenario "User can navigate to the reports index page" do
    sign_in_and_navigate_to_reports_index

    expect(current_path).to eq(reports_path)
    expect(page).to have_content("Reports")
  end


  scenario "User can select different report filters" do
    sign_in_and_navigate_to_reports_index

    expect(page).to have_link("Houses")
    expect(page).to have_link("Check In's")
    expect(page).to have_link("Student Status")
    expect(page).to have_link("Date Range")
  end

  scenario "User can select which houses they'd like to generate a report for" do
    house
    house2
    sign_in_and_navigate_to_reports_index

    expect(page).to have_content(house.name)
    expect(page).to have_content(house2.name)
  end

  scenario "User can select the completed status of a student check as a filter" do
    sign_in_and_navigate_to_reports_index
    click_link "Check In's"

    expect(page).to have_content("All")
    expect(page).to have_content("Complete")
    expect(page).to have_content("Incomplete")
  end

  scenario "User can select the status of the student during a check in" do
    sign_in_and_navigate_to_reports_index
    click_link "Student Status"

    expect(page).to have_content("Asleep")
    expect(page).to have_content("Awake")
    expect(page).to have_content("Bathroom")
    expect(page).to have_content("Pass")
    expect(page).to have_content("Off Campus")
    expect(page).to have_content("Missing")
    expect(page).to have_content("Unchecked")
  end
end
