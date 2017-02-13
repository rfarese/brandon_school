require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should have_valid(:status).when(0, 1) }
  it { should respond_to(:selfie) }

  it { should belong_to(:house) }

  let(:tour) { FactoryGirl.create(:tour) }
  let(:house) { tour.house }

  let(:room1) { FactoryGirl.create(:room, house_id: house.id) }
  let(:room2) { FactoryGirl.create(:room, house_id: house.id) }

  let(:bed1) { FactoryGirl.create(:bed, room_id: room1.id) }
  let(:bed2) { FactoryGirl.create(:bed, room_id: room1.id) }

  let(:student1) { FactoryGirl.create(:student, bed_id: bed1.id) }
  let(:student2) { FactoryGirl.create(:student, bed_id: bed2.id) }

  let(:student_check1) { FactoryGirl.create(:student_check, student_id: student1.id) }
  let(:student_check2) { FactoryGirl.create(:student_check, student_id: student2.id) }

  def student_checks_array
    [ student_check1, student_check2 ]
  end

  def bind_to_tour(student_checks)
    student_checks.each do |student_check|
      tour.student_checks << student_check
    end
  end

  def commplete_and_save_student_check(student_checks)
    student_checks.each do |student_check|
      student_check.complete_status = 1
      student_check.save
    end
  end

  describe "#rooms" do
    it "returns all the rooms associated with the tour" do
      house.rooms << room1
      house.rooms << room2

      expect(tour.rooms.count).to eq(2)
    end
  end

  describe "#students" do
    it "returns all the students associated with the tour" do
      house.rooms << room1
      room1.beds << bed1
      room1.beds << bed2
      bed1.student = student1
      bed2.student = student2

      expect(tour.students.count).to eq(2)
    end
  end

  describe "#complete?" do
    it "returns false if the tour is not finished" do
      bind_to_tour(student_checks_array)

      expect(tour.complete?).to eq(false)
    end

    it "returns true if the tour has been finished" do
      bind_to_tour(student_checks_array)
      commplete_and_save_student_check(student_checks_array)

      expect(tour.complete?).to eq(true)
    end
  end
end
