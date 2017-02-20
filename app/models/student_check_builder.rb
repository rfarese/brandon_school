class StudentCheckBuilder
  # create the number of student_checks by the number of beds and not students
  attr_reader :students, :student_checks, :tour, :rooms

  def initialize(tour)
    @students = tour.students
    @rooms = tour.house.rooms
    @tour = tour
    @student_checks = []
  end

  def beds
    b = []
    rooms.each do |room|
      b << room.beds
    end
    b.flatten
  end

  def bind_to_tour(student_check)
    tour.student_checks << student_check
  end

  def generate
    students.each do |student|
      student_check = StudentCheck.create(
                        student_id: student.id,
                        status: "unchecked",
                        room_id: student.room.id
                        )
      bind_to_tour(student_check)
      student_checks << student_check
    end
    student_checks
  end

  def generate_by_beds
    beds.each do |bed|
      student_check = StudentCheck.create(
                        status: "unchecked",
                        room_id: bed.room.id,
                      )
      bind_to_tour(student_check)
      student_checks << student_check
    end
    student_checks
  end
end
