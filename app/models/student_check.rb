class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

  scope :by_houses, -> (houses) { joins(tour: :house).where(houses: { id: houses }) }
  scope :by_status, -> (statuses) { where(status: statuses) }

  scope :by_date_range, -> (start_date, end_date) {
    where("created_at >= :start_date AND created_at <= :end_date",
    { start_date: start_date, end_date: end_date })
  }

  scope :since, -> (date) { where("created_at >= :date", { date: date }) }

  scope :filters, -> (args) {
    by_date_range(args[:start_date], args[:end_date]).
    from(StudentCheck.by_houses(args[:houses]).
    by_status(args[:statuses]), :student_checks)
  }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end
end
