class StudentCheckBuilder
  attr_reader :students, :student_checks, :tour

  def initialize(tour)
    @students = tour.students
    @tour = tour
    @student_checks = []
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
