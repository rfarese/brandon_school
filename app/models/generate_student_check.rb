class GenerateStudentCheck
  attr_reader :room_id, :checks_and_initials

  def initialize(room_id)
    @room_id = room_id
    @checks_and_initials = []
  end

  def room
    Room.find(room_id)
  end

  def students
    room.students
  end

  def generate
    students.each do |student|
      student_check = StudentCheck.create(student_id: student.id, status: "asleep")
      check_and_initials = { check: student_check, initials: student.initials }
      checks_and_initials << check_and_initials
    end
    checks_and_initials
  end
end
