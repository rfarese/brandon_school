FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "Room#{n}" }
    association :house, factory: :house
  end
end
