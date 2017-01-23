require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should have_valid(:status).when("complete", "incomplete" )}
  it { should_not have_valid(:status).when(nil, "", "completed", "finished") }
  it { should respond_to(:selfie) }

  it { should belong_to(:house) }

  describe "#rooms" do
    it ""
  end

  describe "#beds" do
    it ""
  end

  describe "#students" do
    it ""
  end

  describe "#complete?" do
    it ""
  end
end
