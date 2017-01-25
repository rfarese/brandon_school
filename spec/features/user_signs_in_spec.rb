require 'rails_helper'

RSpec.feature "User sign in;", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  scenario "User views sign in form" do
    visit new_user_session_path

    expect(page).to have_field("Name")
    expect(page).to have_field("Password")
  end

  scenario "User successfully signs in" do
    visit new_user_session_path

    fill_in "Name", with: user.name
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content("Signed in successfully")
  end

  scenario "User does not provide valid information to authenticate" do
    visit new_user_session_path

    fill_in "Name", with: ""
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content("Invalid")
  end
end
