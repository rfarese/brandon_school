FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "staff#{n}@brandonschool.com" }
    sequence(:name) { |n| "Staff#{n}" }
    role "overnight_staff"
    password "password"
    password_confirmation "password"
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@brandonschool.com" }
    sequence(:name) { |n| "Admin#{n}" }
    role "admin"
    password "password"
    password_confirmation "password"
  end
end
