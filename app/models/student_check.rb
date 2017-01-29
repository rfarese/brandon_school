class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end
end
