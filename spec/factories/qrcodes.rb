FactoryGirl.define do
  factory :qrcode do
    image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'photo.jpg'))}
    association :room, factory: :room
  end
end
