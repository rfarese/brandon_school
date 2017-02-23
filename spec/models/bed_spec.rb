require 'rails_helper'

RSpec.describe Bed, type: :model do
  it { should have_valid(:name).when("Bed#1", "Second Bed" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should belong_to(:room) }
 end
