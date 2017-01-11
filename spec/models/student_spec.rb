require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_valid(:initials).when("AJ", "ABX" )}
  it { should_not have_valid(:initials).when(nil, "", "Ronny", "Smith") }

  it { should belong_to(:bed) }
end
