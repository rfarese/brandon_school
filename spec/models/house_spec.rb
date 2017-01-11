require 'rails_helper'

RSpec.describe House, type: :model do
  it { should have_valid(:name).when("House 1", "House 2" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_many(:users).through(:permissions) }
end
