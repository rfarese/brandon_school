FactoryGirl.define do
  factory :selfie do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'photo.jpg')) }
  end
end
