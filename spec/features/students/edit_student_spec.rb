require 'rails_helper'

RSpec.feature "User edits a student;", type: :feature do
  let(:permission)    { FactoryGirl.create(:permission) }
  let(:user)          { permission.user }
  let(:house)         { permission.house }
  let(:room)          { FactoryGirl.create(:room, house_id: house.id) }
  let(:bed)           { FactoryGirl.create(:bed, room_id: room.id) }
  let(:bed2)          { FactoryGirl.create(:bed, room_id: room.id) }
  let(:student)       { FactoryGirl.create(:student, bed_id: bed.id) }
  let(:student_check) { FactoryGirl.create(:student_check, student_id: student.id) }

  def sign_in_and_navigate_to_students_index
    user.role = "admin"
    user.save
    sign_in(user)
    click_link "Students"
  end

  scenario "User successfully edits a student" do
    student
    student_check
    sign_in_and_navigate_to_students_index
    click_link "edit"
    fill_in "Initials", with: "RZ"
    click_button "Submit"

    expect(page).to have_content("RZ")
    expect(page).to have_content("Student Updated")
  end

  scenario "User does not provide valid information" do
    student
    student_check
    sign_in_and_navigate_to_students_index
    click_link "edit"
    fill_in "Initials", with: ""
    click_button "Submit"

    expect(page).to have_content("Please provide valid information.")
  end
end
