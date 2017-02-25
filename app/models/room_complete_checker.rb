class RoomCompleteChecker
  attr_reader :room, :tour, :complete, :student_checks

  def initialize(args)
    @room = args[:room]
    @tour = args[:tour]
    @complete = true
  end

  def student_checks_by_room_and_tour(tour)
    StudentCheck.by_room_and_tour(tour_id: tour.id, room_id: room.id)
  end

  def complete_checker(tour)
    @student_checks = student_checks_by_room_and_tour(tour)
    complete = false if student_checks_incomplete?
  end

  def student_checks_incomplete?
    student_checks.any? { |student_check| student_check.complete_status == "incomplete" }
  end
end
