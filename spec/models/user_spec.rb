require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:name).when("House#1 User", "House#2 User" )}
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:role).when("admin", "overnight_staff") }
  it { should_not have_valid(:role).when(nil, "", "super admin", "staff", "overnight staff") }
  
  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
