class Tour < ActiveRecord::Base
  belongs_to :house
  has_many :student_checks
  mount_uploader :selfie, SelfieUploader
  enum status: { incomplete: 0, complete: 1 }

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

  def current_room_complete?
    incomplete_student_checks.count == 0
  end

  def incomplete_student_checks
    self.student_checks.where(complete: false)
  end
end
