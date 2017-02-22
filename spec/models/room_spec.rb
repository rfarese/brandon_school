require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_valid(:name).when("Room#1", "Second Room" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should belong_to(:house) }
  it { should have_many(:beds) }

  let(:room) { FactoryGirl.create(:room) }

  describe "#create_new_qr_code" do
    it 'creates a new qrcode for the room' do
      room.create_new_qr_code

      expect(room).to respond_to(:qrcode)
    end
  end
end
