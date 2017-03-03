require 'rails_helper'

RSpec.feature "Email notification;", type: :feature do
  let(:house) { FactoryGirl.create(:house) }

  scenario "User recieves an email notification" do
    page.driver.browser.post('/new_notification', house_name: house.name)

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
