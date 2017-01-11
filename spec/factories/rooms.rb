FactoryGirl.define do
  factory :room do
    sequence(:name) { |n| "Staff#{n}" }
    association :house, factory: :house
  end
end
