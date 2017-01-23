class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end
end
