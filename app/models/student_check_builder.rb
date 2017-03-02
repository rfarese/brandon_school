class StudentCheckBuilder
  attr_reader :student_checks, :tour, :rooms

  def initialize(tour)
    # should just call tour.rooms here...
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
