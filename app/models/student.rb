class Student < ActiveRecord::Base
  belongs_to :bed
  validates :initials, presence: true, length: { maximum: 3 }
end
