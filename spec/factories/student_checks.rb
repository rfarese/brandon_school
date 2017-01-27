FactoryGirl.define do
  factory :student_check do
    status "asleep"
    comment "This is the student check comment"
    association :student, factory: :student
  end
end
