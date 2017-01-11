FactoryGirl.define do
  factory :house do
    sequence(:name) { |n| "Staff#{n}" }
    
    association :user, factory: :user
  end
end
