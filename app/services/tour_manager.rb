class TourManager
  attr_reader :house, :beds
  attr_accessor :tour, :current_room, :rooms, :student_checks,
                :current_beds, :current_student_checks, :qrcode_identifier

  def initialize(tour, qrcode_identifier)
    @tour = tour
    @house = tour.house
    @rooms = tour.rooms
    @beds = tour.beds
    @student_checks = tour.student_checks
    @qrcode_identifier = qrcode_identifier
  end

  def organize
    @current_room = Room.find_by(qrcode_identifier: qrcode_identifier)
    create_current_beds
    create_current_student_checks
    set_rooms_complete_status
  end

  def create_current_beds
    @current_beds = beds.find_all { |bed| bed.room_id == current_room.id }
  end

  def create_current_student_checks
    @current_student_checks = student_checks.find_all { |student_check| student_check.room_id == current_room.id }
  end

  def set_rooms_complete_status
    rooms.each do |room|
      set_room_complete_status(room)
    end
  end

  def student_checks_for_room(room)
    student_checks.find_all { |student_check| student_check.room_id == room.id }
  end

  def set_room_complete_status(room)
    room_student_checks = student_checks_for_room(room)

    if student_checks_for_room_incomplete?(room_student_checks)
      room.complete = false
    else
      room.complete = true
    end
  end

  def student_checks_for_room_incomplete?(room_student_checks)
    room_student_checks.any? { |student_check| student_check.complete_status == "incomplete" }
  end
end
