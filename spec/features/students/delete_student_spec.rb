require 'rails_helper'

RSpec.feature "User deletes a student;", type: :feature do
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
    sign_in(user)
    click_link "Students"
  end

  scenario "User views ability to delete a student" do
    student
    student_check
    sign_in_and_navigate_to_students_index

    expect(page).to have_content("delete")
  end

  # NOTE - need phantom.js for both of these tests below

  scenario "User successfully deletes a student"

  scenario "User recieves a notice before deleting a student"
end
