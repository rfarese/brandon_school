require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should have_valid(:status).when("complete", "incomplete" )}
  it { should_not have_valid(:status).when(nil, "", "completed", "finished") }
  it { should respond_to(:selfie) }

  it { should belong_to(:house) }

  describe "#rooms" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:house) { tour.house }
    let(:room1) { Room.create(name: "Room1", house_id: house.id) }
    let(:room2) { Room.create(name: "Room2", house_id: house.id) }

    it "returns all the rooms associated with the tour" do
      house.rooms << room1
      house.rooms << room2

      expect(tour.rooms.count).to eq(2)
    end
  end

  describe "#beds" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:house) { tour.house }
    let(:room) { Room.create(name: "Room1", house_id: house.id) }
    let(:bed) { Bed.create(name: "Bed1", room_id: room.id) }

    it "returns all the beds associated with the tour" do
      house.rooms << room
      room.beds << bed

      expect(tour.beds.count).to eq(1)
    end
  end

  describe "#students" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:house) { tour.house }
    let(:room) { Room.create(name: "Room1", house_id: house.id) }
    let(:bed1) { Bed.create(name: "Bed1", room_id: room.id) }
    let(:bed2) { Bed.create(name: "Bed2", room_id: room.id) }
    let(:student1) { Student.create(initials: "ZZ", bed_id: bed1.id) }
    let(:student2) { Student.create(initials: "AA", bed_id: bed2.id) }

    it "returns all the students associated with the tour" do
      house.rooms << room
      room.beds << bed1
      room.beds << bed2
      bed1.student = student1
      bed2.student = student2

      expect(tour.students.count).to eq(2)
    end
  end

  describe "#complete?" do
    let(:tour) { FactoryGirl.create(:tour) }
    let(:house) { tour.house }
    let(:room) { Room.create(name: "Room1", house_id: house.id) }
    let(:bed1) { Bed.create(name: "Bed1", room_id: room.id) }
    let(:bed2) { Bed.create(name: "Bed2", room_id: room.id) }
    let(:student1) { Student.create(initials: "ZZ", bed_id: bed1.id) }
    let(:student2) { Student.create(initials: "AA", bed_id: bed2.id) }

    it "returns true if the tour has been finished"

    # it "returns true if the tour has been finished" do
    #   house.rooms << room
    #   room.beds << bed1
    #   room.beds << bed2
    #   bed1.student = student1
    #   bed2.student = student2
    #
    #
    # end
  end
end
