FactoryGirl.define do
  factory :permission do
    user
    house
  end

  factory :admin_permission, class: Permission do
    admin
    house
  end
end
