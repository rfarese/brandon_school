require 'rails_helper'

RSpec.describe ReportGenerator, type: :model do
  describe "#initialize" do
    let(:house) { FactoryGirl.create(:house) }
    let(:filters) { {
       houses: house.id,
       "status"=>"all",
       student_status: ["asleep", "awake", "bathroom"],
       "start_date(2i)"=>"2",
       "start_date(3i)"=>"1",
       "start_date(1i)"=>"2017",
       "end_date(2i)"=>"2",
       "end_date(3i)"=>"7",
       "end_date(1i)"=>"2017"
      }
    }
    let(:status) { filters[:status] }

    let(:report_generator) { ReportGenerator.new(filters) }

    it 'creates a filters instance variable' do
      expect(report_generator).to respond_to(:filters)
    end

    it 'creates a status instance variable' do
      expect(report_generator).to respond_to(:status)
    end

    it 'creates an args instance variable' do
      expect(report_generator).to respond_to(:args)
      expect(report_generator.args).to be_kind_of(Hash)
    end
  end
end
