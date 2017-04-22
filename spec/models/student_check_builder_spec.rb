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

    it 'creates a beds instance variable' do
      expect(generator).to respond_to(:beds)
    end

    it 'creates a house istance variable' do
      expect(generator).to respond_to(:house)
    end

    it 'creates a student_checks instance variable' do
      expect(generator).to respond_to(:student_checks)
      expect(generator.student_checks).to be_kind_of(Array)
    end
  end

  describe "#generate" do
    let(:room) { FactoryGirl.create(:room) }
    let(:bed1) { Bed.create(name: "Bed1", room_id: room.id) }
    let(:bed2) { Bed.create(name: "Bed2", room_id: room.id) }
    let(:house) { room.house }
    let(:tour) { Tour.create(
      status: "incomplete",
      house_id: house.id,
      selfie: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'photo.jpg'))
      )}
    let(:generator) { StudentCheckBuilder.new(tour) }

    it 'creates all the student checks for a given room' do
      generator.rooms.first.beds << [bed1, bed2]
      generator.beds << [bed1, bed2]
      generator.generate

      expect(generator.student_checks.count).to eq(2)
    end
  end
end
