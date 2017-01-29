require 'rails_helper'

RSpec.feature "User visits reporting dashboard;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  def sign_in_and_navigate_to_reports_index
    user.role = "admin"
    user.save
    sign_in(user)
    click_link "Reports"
  end

  scenario "User can navigate to the reports dashboard" do
    sign_in_and_navigate_to_reports_index

    expect(current_path).to eq(report_dashboards_path)
    expect(page).to have_content("Reports")
  end
end
