require 'rails_helper'

RSpec.describe Permission, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:house) }
end
