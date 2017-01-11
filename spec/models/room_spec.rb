require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_valid(:name).when("Room#1", "Second Room" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should belong_to(:house) }
end
