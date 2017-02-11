class StudentCheckFinder
  attr_reader :room_id, :tour_id

  def initialize(args)
    @room = Room.find(args[:room_id])
    @tour = Tour.find(args[:tour_id])
  end

  def all_student_checks
    tour.student_checks
  end

  def student_checks_by_room
    s = []
    all_student_checks.each do |student_check|
      s << student_check if student_check.room == room
    end
    s
  end 
end
