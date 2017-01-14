class GenerateStudentCheck
  attr_reader :room_id, :student_checks

  def initialize(room_id)
    @room_id = room_id
    @student_checks = []
  end

  def room
    Room.find(room_id)
  end

  def students
    room.students
  end

  def build
    students.each do |student|
      student_checks << StudentCheck.create(student_id: student.id, status: "asleep")
    end
    student_checks
  end
end
