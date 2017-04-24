class Selfie < ActiveRecord::Base
  has_one :tour
  mount_uploader :image, SelfieUploader
end
