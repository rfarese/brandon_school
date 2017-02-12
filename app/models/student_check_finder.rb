class StudentCheckFinder
  attr_reader :room_id, :tour_id

  def initialize(args)
    @room_id = args[:room_id]
    @tour_id = args[:tour_id]
  end

  def by_room_and_tour
    StudentCheck.where(room_id: room_id, tour_id: tour_id)
  end

  def incomplete_by_room_and_tour
    StudentCheck.where(room_id: room_id, tour_id: tour_id, complete_status: 0)
  end
end
