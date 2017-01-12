class Student < ActiveRecord::Base
  belongs_to :bed
  has_many :student_checks, as: :checkable
  validates :initials, presence: true, length: { maximum: 3 }
end
