require 'rails_helper'

RSpec.feature "User deletes a house;", type: :feature do
  let(:permission) { FactoryGirl.create(:permission) }
  let(:user) { permission.user }
  let(:house) { permission.house }

  def sign_in_and_navigate_to_houses_index
    user.role = "admin"
    sign_in(user)
    click_link "Houses"
  end

  scenario "User successfully deletes a house" do
    sign_in_and_navigate_to_houses_index
    click_link "delete"

    expect(House.count).to eq(0)
  end

  scenario "User recieves a notice before deleting" do
    sign_in_and_navigate_to_houses_index
    click_link "delete"
    expect(page).to have_content("Are you sure?")
  end
end
