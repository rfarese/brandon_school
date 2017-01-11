class Tour < ActiveRecord::Base
  belongs_to :house
  mount_uploader :selfie, SelfieUploader
  validates :status, presence: true, inclusion: { in: %w(complete incomplete) }
end
