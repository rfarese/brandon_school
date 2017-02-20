class Tour < ActiveRecord::Base
  belongs_to :house
  has_many :student_checks
  mount_uploader :selfie, SelfieUploader
  enum status: { incomplete: 0, complete: 1 }

  def selfie_pic
    selfie.file.url
  end

  def rooms
    house.rooms
  end

  def students
    s = []
    rooms.each do |room|
      s << room.students
    end
    s.flatten
  end

  def complete?
    student_checks.where(complete_status: 1).count == students.count
  end

  def current_room_complete?
    incomplete_student_checks.count == 0
  end

  def incomplete_student_checks
    self.student_checks.where(complete_status: 0)
  end

  def build_student_checks
    StudentCheckBuilder.new(self).generate
  end
end
