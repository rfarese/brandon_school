class Tour < ActiveRecord::Base
  belongs_to :house
  has_many :student_checks, as: :checkable
  mount_uploader :selfie, SelfieUploader
  validates :status, presence: true, inclusion: { in: %w(complete incomplete) }
end
