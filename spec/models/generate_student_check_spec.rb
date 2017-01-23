require 'rails_helper'

RSpec.describe GenerateStudentCheck, type: :model do
  describe "#initialize" do
    let(:generator) { GenerateStudentCheck.new({room_id: 2, tour_id: 1}) }

    it 'creates a room_id instance variable' do
      expect(generator).to respond_to(:room_id)
    end

    it 'creates a tour_id instance variable' do
      expect(generator).to respond_to(:tour_id)
    end

    it 'creates a student_checks instance variable' do
      expect(generator).to respond_to(:student_checks)
      expect(generator.student_checks).to be_kind_of(Array)
    end
  end

  describe "#room" do
    let(:room) { FactoryGirl.create(:room) }
    let(:generator) { GenerateStudentCheck.new(room_id: room.id, tour_id: 2) }

    it 'finds a room to build student checks for' do
      expect(generator.room).to eq(room)
    end
  end

  describe "#students" do
    let(:student) { FactoryGirl.create(:student) }
    let(:room) { student.bed.room }
    let(:generator) { GenerateStudentCheck.new(room_id: room.id, tour_id: 2) }

    it "finds the students to build student checks for" do
      expect(generator.students.first).to eq(student)
    end
  end

  describe "#tour" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:generator) { GenerateStudentCheck.new(room_id: 2, tour_id: tour.id) }

    it "finds the current tour" do
      expect(generator.tour).to eq(tour)
    end
  end

  describe "#generate" do
    let(:student) { FactoryGirl.create(:student) }
    let(:bed) { student.bed }
    let(:room) { student.bed.room }
    let(:house) { room.house }
    let(:tour) { Tour.create(
      status: "incomplete",
      house_id: house.id,
      selfie: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'photo.jpg'))
      )}
    let(:generator) { GenerateStudentCheck.new(room_id: room.id, tour_id: tour.id) }

    it 'creates and returns a student check for each student' do
      expect(generator.generate).to eq(generator.student_checks)
    end
  end
end
