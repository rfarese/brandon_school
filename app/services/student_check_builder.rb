class StudentCheckBuilder
  attr_reader :student_checks, :tour, :house, :rooms, :beds

  def initialize(tour)
    # should just call tour.rooms here...
    @tour = tour
    @house = tour.house
    @rooms = tour.house.rooms
    @beds = tour.house.beds
    @student_checks = []
  end

  def bind_to_tour(student_check)
    tour.student_checks << student_check
  end

  def beds_by_room(room)
    beds.find_all { |bed| bed.room_id == room.id }
  end

  def generate
    rooms.each do |room|
      bed_iterator(room, beds_by_room(room))
    end
  end

  def bed_iterator(room, beds)
    beds.each do |bed|
      create_student_check(room.id)
    end
  end

  def create_student_check(room_id)
    student_check = StudentCheck.create(status: "unchecked", room_id: room_id)
    bind_to_tour(student_check)
    student_checks << student_check
  end
end
