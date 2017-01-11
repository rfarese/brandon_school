require 'rails_helper'

RSpec.describe House, type: :model do
  let(:house) { FactoryGirl.create(:house) }

  it { should have_valid(:name).when("House 1", "House 2" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:user_id).when(1, 2, 3) }
  it { should_not have_valid(:user_id).when(nil, "") }

  it "belongs to a user" do
    expect(house).to belong_to(:user)
  end
end
