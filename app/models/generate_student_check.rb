class GenerateStudentCheck
  attr_reader :room_id, :tour_id, :student_checks

  def initialize(args)
    @room_id = args[:room_id]
    @tour_id = args[:tour_id]
    @student_checks = []
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
      student_check = StudentCheck.create(student_id: student.id, status: "unchecked")
      bind_to_tour(student_check)
      student_checks << student_check
    end
    student_checks
  end
end
