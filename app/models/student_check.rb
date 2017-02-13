class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  belongs_to :room
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty unchecked) }

  scope :by_room_and_tour, ->(args) { where(
    room_id: args[:room_id],
    tour_id: args[:tour_id])
  }

  scope :by_houses, -> (houses) { joins(tour: :house).where(houses: { id: houses }) }
  scope :by_status, -> (statuses) { where(status: statuses) }

  scope :by_date_range, -> (start_date, end_date) {
    where("created_at >= :start_date AND created_at <= :end_date",
    { start_date: start_date, end_date: end_date })
  }

  scope :filters, -> (args) {
    by_date_range(args[:start_date], args[:end_date]).
    from(StudentCheck.by_houses(args[:houses]).
    by_status(args[:statuses]), :student_checks).
    order(created_at: :desc)
  }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end

  def house
    tour.house
  end
end
