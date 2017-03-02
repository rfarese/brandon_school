require 'rails_helper'

RSpec.feature "User exports a report;", type: :feature do
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

  scenario "User successfully exports a report"

end
