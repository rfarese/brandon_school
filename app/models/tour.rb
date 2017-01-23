class Tour < ActiveRecord::Base
  belongs_to :house
  has_many :student_checks
  mount_uploader :selfie, SelfieUploader
  # change status to 'complete' with true and false values
  validates :status, presence: true, inclusion: { in: %w(complete incomplete) }

  def rooms
    house.rooms
  end

  def beds
    b = []
    rooms.each do |room|
      b << room.beds
    end
    b.flatten
  end

  def students
    s = []
    beds.each do |bed|
      s << bed.student if bed.student
    end
    s
  end

  def complete?
    self.student_checks.where(complete: true).count == self.students.count
  end
end
