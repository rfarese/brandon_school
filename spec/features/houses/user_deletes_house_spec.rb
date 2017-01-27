require 'rails_helper'

RSpec.feature "User deletes a house;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate_to_houses_index
    user.role = "admin"
    user.save
    sign_in(user)
    click_link "Houses"
  end

  scenario "User views ability to delete a house" do
    sign_in_and_navigate_to_houses_index

    expect(page).to have_content("delete")
  end

  # NOTE - need phantom.js for both of these tests below

  scenario "User successfully deletes a house"

  scenario "User recieves a notice before deleting"
end
