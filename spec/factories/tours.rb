FactoryGirl.define do
  factory :tour do
    status 0
    association :house, factory: :house
    association :selfie, factory: :selfie
  end
end
