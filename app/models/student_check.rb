class StudentCheck < ActiveRecord::Base
  belongs_to :tour
  belongs_to :student
  enum complete_status: { incomplete: 0, complete: 1 }
  validates :status, presence: true, inclusion: { in: %w(asleep awake bathroom pass off_campus missing empty) }

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
