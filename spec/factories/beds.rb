FactoryGirl.define do
  factory :bed do
    sequence(:name) { |n| "Bed#{n}" }
    association :room, factory: :room
  end
end
