class GenerateStudentCheck
  attr_reader :room_id, :tour_id, :checks_and_initials

  def initialize(args)
    @room_id = args[:room_id]
    @tour_id = args[:tour_id]
    @checks_and_initials = []
  end

  def room
    Room.find(room_id)
  end

  def students
    room.students
  end

  def tour
    Tour.find(tour_id)
  end

  def bind_to_tour(student_check)
    tour.student_checks << student_check
  end

  def generate
    students.each do |student|
      student_check = StudentCheck.create(student_id: student.id, status: "asleep")
      bind_to_tour(student_check)
      check_and_initials = { check: student_check, initials: student.initials }
      checks_and_initials << check_and_initials
    end
    checks_and_initials
  end
end
