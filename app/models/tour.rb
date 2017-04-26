class Tour < ActiveRecord::Base
  belongs_to :house
  belongs_to :selfie
  has_many :student_checks
  enum status: { incomplete: 0, complete: 1 }

  scope :today, -> { includes(:selfie, :student_checks).where(updated_at: (Time.now - 24.hours)..Time.now) }

  scope :last_night, -> {
    includes([:student_checks, :house]).
    where(updated_at: ((Time.parse "11:00 pm") - 24.hours)..Time.now)
  }

  scope :current_tour, -> (tour_id) {
    includes(:student_checks, house: [:rooms, :beds]).
    find(tour_id)
  }

  def rooms
    house.rooms
  end

  def beds
    house.beds
  end

  def complete?
    student_checks.where(complete_status: 1).count == house.beds.count
  end

  def incomplete_student_checks
    self.student_checks.where(complete_status: 0)
  end

  def build_student_checks
    StudentCheckBuilder.new(self).generate
  end

  def self.most_recent_by_house
    Tour.includes(:house).where(id: (Tour.group(:house_id).maximum(:id).values))
  end
end
