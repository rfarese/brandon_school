require 'rails_helper'

RSpec.feature "User sign out;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario "User views the ability to sign out" do
    sign_in(user)

    expect(page).to have_link("Sign out")
    expect(page).to_not have_link("Sign in")
  end

  scenario "User successfully signs out" do
    sign_in(user)
    click_link "Sign out"

    expect(page).to have_content("Signed out successfully")
  end

  scenario "User doesn't view the ability to sign out if they are not signed in" do
    visit new_user_session_path

    expect(page).to_not have_link("Sign out")
  end
end
