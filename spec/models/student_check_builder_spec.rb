require 'rails_helper'

RSpec.describe StudentCheckBuilder, type: :model do
  describe "#initialize" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:generator) { StudentCheckBuilder.new(tour) }

    it 'creates a rooms instance variable' do
      expect(generator).to respond_to(:rooms)
    end

    it 'creates a tour instance variable' do
      expect(generator).to respond_to(:tour)
    end

    it 'creates a student_checks instance variable' do
      expect(generator).to respond_to(:student_checks)
      expect(generator.student_checks).to be_kind_of(Array)
    end
  end

  describe "#beds" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:generator) { StudentCheckBuilder.new(tour) }

    it "returns an array of the beds for the current tour" do
      expect(generator.beds).to be_kind_of(Array)
      expect(generator)
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
