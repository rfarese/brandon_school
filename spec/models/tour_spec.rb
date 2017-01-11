require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should have_valid(:status).when("complete", "incomplete" )}
  it { should_not have_valid(:status).when(nil, "", "completed", "finished") }

  it { should belong_to(:house) }
end
