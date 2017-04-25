class RoomCompleteChecker
  attr_reader :rooms, :student_checks, :tour

  def initialize(tour)
    @tour = tour
    @house = tour.house
    @student_checks = tour.student_checks
  end

  def set_status
    rooms.each do |room|
      room.complete_checker
    end
  end

  def student_checks_by_room_and_tour(tour)
    StudentCheck.by_room_and_tour(tour_id: tour.id, room_id: self.id)
  end

  def complete_checker
    student_checks = student_checks_by_room_and_tour(tour)
    if student_checks_incomplete?(student_checks)
      @complete = false
    else
      @complete = true
    end
  end

  def student_checks_incomplete?
    student_checks.any? { |student_check| student_check.complete_status == "incomplete" }
  end
end
