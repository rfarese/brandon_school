FactoryGirl.define do
  factory :student do
    sequence(:initials) { |n| "S#{n}" }
    association :bed, factory: :bed
  end
end
