FactoryGirl.define do
  factory :student_check do
    status "asleep"
    association :student, factory: :student
  end
end
