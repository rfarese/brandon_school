class StudentCheck < ActiveRecord::Base
  belongs_to :checkable, polymorphic: true
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }
end
