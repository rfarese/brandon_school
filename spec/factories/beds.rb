FactoryGirl.define do
  factory :bed do
    sequence(:name) { |n| "Room#{n}" }
    association :room, factory: :room
  end
end
