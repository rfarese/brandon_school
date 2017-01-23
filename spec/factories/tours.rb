FactoryGirl.define do
  factory :tour do
    status "incomplete"
    selfie { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'photo.jpg')) }
    association :house, factory: :house
  end
end
