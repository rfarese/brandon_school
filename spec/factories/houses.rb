FactoryGirl.define do
  factory :house do
    sequence(:name) { |n| "Staff#{n}" }    
  end
end
