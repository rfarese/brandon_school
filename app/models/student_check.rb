class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

  scope :from_houses, -> (houses) { joins(tour: :house).where(houses: { id: houses }) }
  scope :by_status, -> (statuses) { where(status: statuses) }
  scope :by_date_range, -> (start_date, end_date) {
    where("created_at >= :start_date AND created_at <= :end_date",
    { start_date: start_date, end_date: end_date }) }
  scope :since, -> (date) { where("created_at >= :date", { date: date }) }

  def bed
    self.student.bed
  end

  def room
    bed.room
  end

  def self.ids_by_house(houses)
    # think about how this could be a straight query and a pluck
    # the pluck should grab the id's
    ids = []
    houses.each do |house|
      house.tours.each do |tour|
        tour.student_checks.each do |student_check|
          ids << student_check.id
        end
      end
    end
    ids.flatten
  end

# this is the same method as StudentCheck.incomplete
  def self.from_incomplete_tours
    joins(:tour).where(tours: { status: 0 } )
  end
end
