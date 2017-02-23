require 'rails_helper'

RSpec.describe StudentCheck, type: :model do
  it { should have_valid(:status).when("asleep", "awake", "bathroom", "pass", "off_campus", "missing", "empty", "unchecked") }
  it { should_not have_valid(:status).when(nil, "", "something", "walking") }
  it { should have_valid(:comment).when("this is the first comment", "this is the 2 or 3'rd comment" ) }
  it { should have_valid(:complete_status).when(0, 1) }
  it { should belong_to(:tour) }
end
