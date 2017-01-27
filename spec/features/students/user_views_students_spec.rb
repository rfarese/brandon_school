require 'rails_helper'

RSpec.feature "User views all students;", type: :feature do
  let(:permission)    { FactoryGirl.create(:permission) }
  let(:user)          { permission.user }
  let(:house)         { permission.house }
  let(:room)          { FactoryGirl.create(:room, house_id: house.id) }
  let(:bed)           { FactoryGirl.create(:bed, room_id: room.id) }
  let(:student)       { FactoryGirl.create(:student, bed_id: bed.id) }
  let(:student_check) { FactoryGirl.create(:student_check, student_id: student.id) }

  def sign_in_and_navigate_to_students_index
    user.role = "admin"
    sign_in(user)
    click_link "Students"
  end

  scenario "User navigates to the student index page" do
    sign_in_and_navigate_to_students_index

    expect(current_path).to eq(students_path)
  end

  scenario "User views all existing students" do
    student
    student_check
    sign_in_and_navigate_to_students_index

    expect(page).to have_content(student.initials)
    expect(page).to have_content(student.bed.name)
  end
end
