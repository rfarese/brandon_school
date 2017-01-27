class Student < ActiveRecord::Base
  belongs_to :bed
  has_many :student_checks
  validates :initials, presence: true, length: { maximum: 3 }
  validates :bed, presence: true 

  def recent_check
    self.student_checks.last
  end

  def no_recent_check
    if self.student_checks.count == 0
      return true
    else
      return false
    end
  end

  def self.available_beds
    b = []
    Bed.all.each do |bed|
      unless bed.student
        b << bed
      end
    end
    b
  end
end
